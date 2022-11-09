////
////  HomeVC.swift
////  FrontendAppKit
////
////  Created by Subhrajyoti Patra on 11/9/22.
////
//
//import CommonKit
//
//import RxCocoa
//import RxSwift
//import Swinject
//import UIKit
//
//class HomeVC: UIViewController, UITableViewDelegate {
//
//    @IBOutlet weak var homeTableView: UITableView!
//
//    init() {
//
//        viewModel = Home.VM.Factory.create(with: resolver)
//
//        super.init()
//    }
//
//    required init?(coder: NSCoder) {
//
//        viewModel = Home.VM.Factory.create(with: resolver)
//
//        super.init(coder: coder)
//    }
//
//    override func viewDidLoad() {
//
//        super.viewDidLoad()
//
//        bindTableView()
//    }
//
//    // MARK: Overrides:
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        150
//    }
//
//    // MARK: Privates:
//
//    private let resolver = Container.default.resolver
//    private let viewModel: Home.VM.Interface
//    private let disposeBag = DisposeBag()
//
//    private func addEdgeViews() {
//
//        var frame = UIScreen.main.bounds
//        frame.origin.y = -frame.size.height
//        let bounceView = UIView(frame: frame)
//        bounceView.backgroundColor = .white
//        self.view.addSubview(bounceView)
//
//        homeTableView.backgroundColor = Styles.ColorIds.highEmphasis
//    }
//
//    private func bindTableView() {
//
//        homeTableView
//
//            .rx
//            .setDelegate(self)
//            .disposed(by: disposeBag)
//
//        viewModel.staffPickMovies.asObservable()
//
//            .bind(
//
//                to: homeTableView.rx.items(
//
//                    cellIdentifier: "staffPickTableCell",
//                    cellType: MovieTableCell.self
//
//                )
//
//            ) {
//
//                [weak self] index, movieVM, cell in
//
//                guard let this = self else {
//
//                    return
//                }
//
//                if index != 0 {
//
//                    let separatorView = UIView(
//
//                        frame: CGRect(
//
//                            x: 110,
//                            y:0,
//                            width: this.homeTableView.frame.width-140,
//                            height: 1
//                        )
//                    )
//                    separatorView.backgroundColor = Styles.ColorIds.lowEmphasisLight
//
//                    cell.addSubview(separatorView)
//                }
//
//                cell.ratingView.rating = movieVM.rating
//                cell.titleLabel.text = movieVM.title
//                cell.yearLabel.text = movieVM.releaseYear
//
//                movieVM.isFavourite.drive(cell.favoritesButton.rx.isOn)
//
//                    .disposed(by: this.disposeBag)
//
//                cell.favoritesButton.rx.tap
//
//                    .subscribe(onNext: {
//
//                        movieVM.toggleFavorite()
//                    })
//                    .disposed(by: this.disposeBag)
//
//                movieVM.getImage()
//
//                    .subscribe(onSuccess: { image in
//
//                        cell.moviePosterView.image = image
//
//                    }, onFailure: { error in
//
//                        print("Unable to fetch movie poster: \(error.localizedDescription)")
//
//                        cell.moviePosterView.image = Styles.Images.Favorites.off.light
//                    })
//                    .disposed(by: this.disposeBag)
//            }
//            .disposed(by: disposeBag)
//    }
//}
