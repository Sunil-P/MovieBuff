//
//  Search+TableVC.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/28/22.
//

import RxSwift
import UIKit

class Search_TableVC: UITableViewController {

    var movieCellClicked: ((Movie.VM.Interface)->())?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: UITableViewDelegate:

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        150
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        let view = UIView()

        view.backgroundColor = Styles.ColorIds.highEmphasis

        return view
    }

    // MARK: Interface:

    func setupTableView(viewModel: Search.VM.Interface) {

        tableView.delegate = nil
        tableView.dataSource = nil

        Observable.combineLatest(

            viewModel.movieVMs, tableView.rx.itemSelected

        )
        .subscribe(onNext: { [weak self] movieVMs, itemIndex in

            let movieVM = movieVMs[itemIndex.row]

            self?.movieCellClicked?(movieVM)
        })
        .disposed(by: disposeBag)

        viewModel.movieVMs.bind(

            to: tableView.rx.items(cellIdentifier: "movieCell", cellType: MovieTableCell.self)

        ) { [weak self] row, movieVM, cell in

            guard let this = self else {

                return
            }

            cell.separatorView.frame = CGRect(

                x: 110, y: 0,
                width: this.tableView.frame.width-140, height: 1
            )

            cell.separatorView.isHidden = row == 0 ? true : false
            cell.ratingView.rating = movieVM.rating
            cell.titleLabel.text = movieVM.title
            cell.yearLabel.text = movieVM.releaseYear

            if let previousDisposable = this.disposables[row] {

                previousDisposable.dispose()
            }

            let favoriteBtnStateDisposable = movieVM.isFavourite.drive(

                cell.favoritesButton.rx.isOn
            )

            let favoriteBtnTapDisposable = cell.favoritesButton.rx.tap

                .subscribe(onNext: {

                    movieVM.toggleFavorite()
                })

            let imgDisposable = movieVM.getImage()

                .observe(on: MainScheduler.instance)
                .subscribe(onSuccess: { image in

                    cell.moviePosterView.image = image

                }, onFailure: { error in

                    print("Unable to fetch movie poster: \(error.localizedDescription)")

                    cell.moviePosterView.image = Styles.Images.Favorites.off.light
                })

            this.disposeBag.insert([

                favoriteBtnStateDisposable,
                favoriteBtnTapDisposable,
                imgDisposable,
            ])

            let disposable = CompositeDisposable(

                favoriteBtnStateDisposable,
                favoriteBtnTapDisposable,
                imgDisposable
            )

            this.disposables[row] = disposable

        }.disposed(by: disposeBag)

        tableView.rx

            .setDelegate(self)
            .disposed(by: disposeBag)
    }

    // MARK: Privates:

    private let disposeBag = DisposeBag()

    private var disposables = [Int: CompositeDisposable]()

} // Search_TableVC
