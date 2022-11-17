//
//  Home+VC.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/9/22.
//

import RxDataSources
import RxCocoa
import RxSwift
import Swinject
import UIKit

class Home_VC: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!

    required init?(coder: NSCoder) {

        viewModel = Home.VM.Factory.create(with: resolver)

        super.init(coder: coder)

        print("Home.VC has been constructed.")
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        addEdgeViews()
        bindTableView()

        print("Home.VC did init.")
    }

    deinit {

        print("~Home.VC has been constructed.")
    }

    // MARK: Segue:

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "searchButtonSegue" {

            let _ = segue.destination as! Search_VC

        } else if segue.identifier == "homeDetailsSegue" {

            let detailsVC = segue.destination as! Details_VC

            setupDetailsVC?(detailsVC)
        }
    }

    // MARK: Privates:

    private let resolver = Container.default.resolver
    private let viewModel: Home.VM.Interface
    private let disposeBag = DisposeBag()

    private var setupDetailsVC: ((_ detailsVC: Details_VC)->())?
    private var disposables = [Int: CompositeDisposable]()

    private func addEdgeViews() {

        var frame = UIScreen.main.bounds
        frame.origin.y = -frame.size.height
        let bounceView = UIView(frame: frame)
        bounceView.backgroundColor = .white
        homeTableView.addSubview(bounceView)

        homeTableView.backgroundColor = Styles.ColorIds.highEmphasis
    }

    @objc private func searchButtonClicked(sender: UIButton) {

        print("Search button clicked")

        navigateToSearch()
    }

    private func movieClicked(vm: Movie.VM.Interface) {

        setupDetailsVC = { detailsVC in

            detailsVC.setup(movieVM: vm)
        }
        performSegue(withIdentifier: "homeDetailsSegue", sender: self)
    }

    private func navigateToSearch() {

        performSegue(withIdentifier: "searchButtonSegue", sender: self)
    }

    private func bindTableView() {

        Observable.combineLatest(

            viewModel.tableViewSections,
            homeTableView.rx.itemSelected

        )
        .subscribe(onNext: { [weak self] tableViewSections, selectedIndex in

            guard selectedIndex.section == 2 else {

                return
            }

            let staffPickSection = tableViewSections[2]
            if let selectedMovie = staffPickSection.items[selectedIndex.row] as? Home.StaffPickMovieRowItem {

                self?.movieClicked(vm: selectedMovie.movieVM)
            }
        })
        .disposed(by: disposeBag)

        let dataSource = RxTableViewSectionedReloadDataSource<Home.RowSection>(

            configureCell: { [weak self] dataSource, tableView, indexPath, item in

                switch indexPath.section {

                case 0:

                    let cell = tableView.dequeueReusableCell(withIdentifier: "searchButtonTableCell", for: indexPath)

                    if let searchButtonCell = cell as? SearchButtonTableCell {

                        self?.bindSearchRowItem(cell: searchButtonCell)
                    }

                    return cell

                case 1:

                    let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesMovieTableCell", for: indexPath)

                    if let favoritesMovieCell = cell as? CollectionViewMovieTableCell {

                        self?.bindFavoritesRowItem(cell: favoritesMovieCell)
                    }

                    return cell

                default:

                    let cell = tableView.dequeueReusableCell(withIdentifier: "staffPickTableCell", for: indexPath)

                    if let favoritesMovieCell = cell as? MovieTableCell,
                        let rowItem = item as? Home.StaffPickMovieRowItem {

                        self?.bindMovieTableCell(

                            cell: favoritesMovieCell,
                            rowItem: rowItem,
                            indexPath: indexPath,
                            tableView: tableView
                        )
                    }

                    return cell
                }
            }
        )

        viewModel.tableViewSections

            .bind(to: homeTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        homeTableView.rx

            .setDelegate(self)
            .disposed(by: disposeBag)

        let refreshControl = UIRefreshControl()
        homeTableView.refreshControl = refreshControl
        refreshControl.rx.controlEvent(.valueChanged)

            .subscribe(onNext: { [weak self] in

                self?.viewModel.refreshAvailableMovies()
            })
            .disposed(by: disposeBag)

        viewModel.isRefreshing

            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
    }

    private func bindSearchRowItem(cell: SearchButtonTableCell) {

        cell.searchButton

            .addTarget(self, action: #selector(searchButtonClicked(sender:)), for: .touchUpInside)
    }

    private func bindFavoritesRowItem(cell: CollectionViewMovieTableCell) {

        cell.favouriteMovieBtnClicked = { [weak self] movieVM in

            self?.movieClicked(vm: movieVM)
        }

        cell.seeAllBtnClicked = { [weak self] in

            self?.navigateToSearch()
        }
    }

    private func bindMovieTableCell(

        cell: MovieTableCell,
        rowItem: Home.StaffPickMovieRowItem,
        indexPath: IndexPath,
        tableView: UITableView

    ) {

        cell.separatorView.frame = CGRect(

            x: 110, y:0,
            width: tableView.frame.width-140, height: 1
        )

        cell.separatorView.isHidden = indexPath.row == 0 ? true : false
        cell.ratingView.rating = rowItem.movieVM.rating
        cell.titleLabel.text = rowItem.movieVM.title
        cell.yearLabel.text = rowItem.movieVM.releaseYear

        if let previousDisposable = disposables[indexPath.row] {

            previousDisposable.dispose()
        }

        let favoriteBtnStateDisposable = rowItem.movieVM.isFavourite.drive(

            cell.favoritesButton.rx.isOn
        )

        let favoriteBtnTapDisposable = cell.favoritesButton.rx.tap

            .subscribe(onNext: {

                rowItem.movieVM.toggleFavorite()
            })

        let imgDisposable = rowItem.movieVM.getImage()

            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { image in

                cell.moviePosterView.image = image

            }, onFailure: { error in

                print("Unable to fetch movie poster: \(error.localizedDescription)")
                cell.moviePosterView.image = Styles.Images.Favorites.off.light
            })

        disposeBag.insert([

            favoriteBtnStateDisposable,
            favoriteBtnTapDisposable,
            imgDisposable,
        ])

        let disposable = CompositeDisposable(

            favoriteBtnStateDisposable,
            favoriteBtnTapDisposable,
            imgDisposable
        )

        disposables[indexPath.row] = disposable
    }

} // Home_VC

extension Home_VC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0 {

            return 80

        } else if indexPath.section == 1 {

            return 300

        } else {

            return 150
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        let view = UIView()

        if section > 0 {

            view.backgroundColor = Styles.ColorIds.highEmphasis

        } else {

            view.backgroundColor = .white
        }

        return view
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard section != 0 else {

            let view = UIView()

            view.backgroundColor = .white

            return view
        }

        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))

        let label = UILabel()
        label.frame = CGRect.init(x: 30, y: 0, width: headerView.frame.width, height: headerView.frame.height-10)
        label.font = .systemFont(ofSize: 12)
        label.textColor = Styles.ColorIds.highEmphasis
        headerView.addSubview(label)
        headerView.backgroundColor = .white

        if section == 1 {

            let sectionHeaderString = NSMutableAttributedString(

                string:"YOUR",
                attributes: Styles.AttributedTypography.regularTypographyLight
            )
            let suffixString = NSMutableAttributedString(

                string:" FAVORITES",
                attributes:Styles.AttributedTypography.boldTypographyLight
            )

            sectionHeaderString.append(suffixString)
            label.attributedText = sectionHeaderString

        } else if section == 2 {

            let sectionHeaderString = NSMutableAttributedString(

                string:"OUR",
                attributes: Styles.AttributedTypography.regularTypographyDark
            )
            let suffixString = NSMutableAttributedString(

                string:" STAFF PICKS",
                attributes: Styles.AttributedTypography.boldTypographyDark
            )

            sectionHeaderString.append(suffixString)
            label.attributedText = sectionHeaderString

            headerView.backgroundColor = Styles.ColorIds.highEmphasis
        }

        return headerView
    }

} // Home_VC
