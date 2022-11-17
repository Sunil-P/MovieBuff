//
//  Details+VC.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/29/22.
//

import UIKit
import RxSwift

class Details_VC: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()
        setupViews()

        print("Details.VC did load.")
    }

    deinit {

        print("~Details.VC has been destructed.")
    }

    func setup(movieVM: Movie.VM.Interface) {

        self.movieVM = movieVM
    }

    // MARK: IBOutlets:

    // Header Section
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var favoriteButton: FavoritesButton!

    // Content Section - Movie Details
    @IBOutlet weak var moviePosterImageView: CustomImageView!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var movieDetailsTitleLabel: UILabel!
    @IBOutlet weak var pillListView: PillListView!

    // Content Section - Overview
    @IBOutlet weak var overviewLabel: UILabel!

    // Content Section - Director
    @IBOutlet weak var directorImageView: CustomImageView!

    // Content Section - Actors
    @IBOutlet weak var actorsVStackView: UIStackView!

    // Content Section - Keyfacts
    @IBOutlet weak var budgetKeyFactView: KeyfactView!
    @IBOutlet weak var revenueKeyFactView: KeyfactView!
    @IBOutlet weak var languageKeyFactView: KeyfactView!
    @IBOutlet weak var ratingKeyFactView: KeyfactView!

    // MARK: IBActions:

    @IBAction func handleCloseButtonAction(_ sender: Any) {

        self.dismiss(animated: true)
    }

    @IBAction func handleFavoritesButtonAction(_ sender: Any) {

        movieVM?.toggleFavorite()
    }

    // MARK: Privates:

    private let disposeBag = DisposeBag()

    private var movieVM: Movie.VM.Interface?

    private func setupViews() {

        favoriteButton.overriddenTheme = .light

        guard let movieVM = movieVM else {
            return
        }

        movieTitleLabel.text = movieVM.title
        ratingView.rating = movieVM.rating
        runtimeLabel.text = movieVM.runtime

        let movieString = NSMutableAttributedString(

            string: movieVM.title,
            attributes: Styles.AttributedTypography.movieTypography
        )
        let yearString = NSMutableAttributedString(

            string:" (\(movieVM.releaseYear))",
            attributes:Styles.AttributedTypography.yearTypography
        )

        movieString.append(yearString)
        movieDetailsTitleLabel.attributedText = movieString

        movieVM.movieTags.forEach { tag in

            pillListView.addPillLabel(tag)
        }
        overviewLabel.text = movieVM.overview

        directorImageView.title = movieVM.director.name

        budgetKeyFactView.fact = movieVM.factBudget
        revenueKeyFactView.fact = movieVM.factRevenue
        ratingKeyFactView.fact = movieVM.factRating
        languageKeyFactView.fact = movieVM.factLanguage

        movieVM.isFavourite.drive(

            favoriteButton.rx.isOn
        )
        .disposed(by: disposeBag)

        movieVM.getImage()

            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] image in

                self?.moviePosterImageView.image = image
            }
            .disposed(by: disposeBag)

        movieVM.director.getImage()

            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] image in

                self?.directorImageView.image = image
            }
            .disposed(by: disposeBag)

        addCastViews(cast: movieVM.cast)
    }

    private func addCastViews(cast: [Person.VM.Interface]) {

        actorsVStackView.arrangedSubviews.forEach { view in

            view.removeFromSuperview()
        }

        let possibleWidth = view.frame.width - (30 + 5)
        let imagesPerStack = Int((possibleWidth/100).rounded(.down))

        var stackView = UIStackView()

        (0..<cast.count).forEach { index in

            if index % imagesPerStack == 0 {

                stackView = UIStackView()
                stackView.axis = .horizontal
                stackView.spacing = 20
                stackView.distribution = .fillEqually

                actorsVStackView.addArrangedSubview(stackView)
            }

            let personVM = cast[index]

            let personView = CustomImageView(frame: .init(x: 0, y: 0, width: 100, height: 150))

            personVM.getImage()

                .observe(on: MainScheduler.instance)
                .subscribe(onSuccess: { image in

                    personView.image = image
                })
                .disposed(by: disposeBag)

            personView.title = personVM.name

            if let character = personVM.character {

                personView.subtitle = character
            }

            let label = UILabel()
            label.text = "ABC"

            personView.widthAnchor.constraint(equalToConstant: 100).isActive = true
            personView.heightAnchor.constraint(equalToConstant: 150).isActive = true

            stackView.addArrangedSubview(personView)
        }
    }

} // Details_VC
