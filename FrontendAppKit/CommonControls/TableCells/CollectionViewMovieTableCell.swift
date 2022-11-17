//
//  CollectionViewMovieTableCell.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/29/22.
//

import RxSwift
import Swinject
import UIKit

class CollectionViewMovieTableCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    required init?(coder: NSCoder) {

        let resolver = Container.default.resolver

        self.viewModel = Home.VM.Factory.create(with: resolver)

        super.init(coder: coder)
    }
    override func awakeFromNib() {

        super.awakeFromNib()

        backgroundView = BackgroundView()

        setup()
    }

    // MARK: -

    var favouriteMovieBtnClicked: ((_ movieVM: Movie.VM.Interface)->())?
    var seeAllBtnClicked: (() -> ())?

    func setup() {

        viewModel.collectionCellVMs

            .bind(to: collectionView.rx.items) { [weak self] collectionView, row, element in

                let indexPath = IndexPath(row: row, section: 0)

                if let movieCellVM = element as? MovieCollectionCellVM {

                    let movieCell = collectionView.dequeueReusableCell(

                        withReuseIdentifier: "favoritesMovieCollectionCell", for: indexPath

                    ) as! MovieCollectionCell

                    self?.bindMovieCell(movieCell: movieCell, movieCellVM: movieCellVM, indexPath: indexPath)

                    return movieCell

                } else if let _ = element as? SeeAllCellVM {

                    let seeAllCell = collectionView.dequeueReusableCell(

                        withReuseIdentifier: "favoritesSeeAllCollectionCell", for: indexPath

                    ) as! SeeAllCollectionCell

                    self?.bindSeeAllCell(seeAllCell: seeAllCell)

                    return seeAllCell
                }

                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
    }

    // MARK: Privates:

    private let disposeBag = DisposeBag()
    private let viewModel: Home.VM.Interface

    private var disposables = (

        image: [Int: SerialDisposable](),
        ()
    )

    private func bindMovieCell(

        movieCell: MovieCollectionCell,
        movieCellVM: MovieCollectionCellVM,
        indexPath: IndexPath

    ) {

        let imageDisposable = SerialDisposable()
        imageDisposable.disposable = movieCellVM.movie.getImage()

            .observe(on: MainScheduler.instance)
            .subscribe { image in

                movieCell.setupImage(image: image)

            } onFailure: { error in

                print("Error= \(error.localizedDescription)")
            }

        movieCell.cellButtonClicked = { [weak self] in

            self?.favouriteMovieBtnClicked?(movieCellVM.movie)
        }

        disposeBag.insert([

            imageDisposable,
        ])

        disposables.image[indexPath.row] = imageDisposable
    }

    private func bindSeeAllCell(seeAllCell: SeeAllCollectionCell) {

        seeAllCell.cellButtonClicked = { [weak self] in

            self?.seeAllBtnClicked?()
        }
    }

} // CollectionViewMovieTableCell
