//
//  Search+VC.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/3/22.
//

import RxSwift
import Swinject
import UIKit

class Search_VC: UIViewController {

    var tableViewController: Search_TableVC!

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var ratingCollectionView: UICollectionView!
    @IBOutlet weak var noAvailableMoviesView: UIView!
    
    @IBAction func backButtonAction(_ sender: UIButton) {

        print("Back button has been clicked.")

        self.dismiss(animated: true)
    }

    @IBAction func textFieldDidChange(_ sender: UITextField) {

        viewModel.updateTextFilter(text: sender.text ?? "")
    }

    init() {

        print("Search.VC constructing...")

        viewModel = Search.VM.Factory.create(with: resolver)

        super.init()

        print("Search.VC has been constructed.")
    }

    required init?(coder: NSCoder) {

        print("Search.VC constructing...")

        viewModel = Search.VM.Factory.create(with: resolver)

        super.init(coder: coder)

        print("Search.VC has been constructed.")
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search all movies",
            attributes: [NSAttributedString.Key.foregroundColor: Styles.ColorIds.lowEmphasisLight]
        )
        ratingCollectionView.delegate = self
        ratingCollectionView.dataSource = self

        tableViewController.movieCellClicked = { [weak self] movieVM in

            self?.setupDetailsVC = { detailsVC in

                detailsVC.setup(movieVM: movieVM)
            }

            DispatchQueue.main.async {

                self?.performSegue(withIdentifier: "searchDetailsSegue", sender: self)
            }
        }

        tableViewController.setupTableView(viewModel: viewModel)

        print("Search.VC did load.")
    }

    deinit {

        print("~Search.VC has been destructed.")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {

        .lightContent
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "tableViewEmbedSegue" {

            if let vc = segue.destination as? Search_TableVC {

                self.tableViewController = vc

                self.setupTableVC()
            }

        } else if segue.identifier == "searchDetailsSegue" {

            let detailsVC = segue.destination as! Details_VC

            setupDetailsVC?(detailsVC)
        }
    }

    // MARK: Privates:

    private let disposeBag = DisposeBag()
    private let viewModel: Search.VM.Interface
    private let resolver = Container.default.resolver

    private var setupDetailsVC: ((_ detailsVC: Details_VC)->())?

    private func setupTableVC() {

        let refreshControl = UIRefreshControl()
        tableViewController.refreshControl = refreshControl
        refreshControl.rx.controlEvent(.valueChanged)

            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in

                self?.viewModel.refreshAvailableMovies()
            })
            .disposed(by: disposeBag)

        viewModel.isRefreshing

            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)

        viewModel.movieVMs

            .map { $0.isEmpty }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in

                self?.noAvailableMoviesView.isHidden = !$0
                self?.tableViewController.tableView.isHidden = $0
            })
            .disposed(by: disposeBag)
    }
}

extension Search_VC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let index = 5 - indexPath.row

        let paddingX = 16
        let marginX = 2
        let marginY = 10
        let imageWidth = 10
        let imageHeight = 10

        let width = CGFloat(index * imageWidth + (index - 1) * marginX + paddingX * 2)
        let height = CGFloat(imageHeight + marginY + marginY)

        return .init(width: width , height: height)
    }
}

extension Search_VC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(

            withReuseIdentifier: "ratingButtonCollectionCell", for: indexPath

        ) as! RatingCollectionCell

        cell.ratingButton.rating = 5-indexPath.row
        cell.cellButtonClicked = { [weak self] in

            cell.ratingButton.isOn.toggle()
            self?.viewModel.updateRatingFilter(rating: cell.ratingButton.rating)
        }

        return cell
    }
}
