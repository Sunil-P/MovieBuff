//
//  Details+VC.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/29/22.
//

import UIKit

class Details_VC: UIViewController {

    // Header Section
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var favoriteButton: FavoritesButton!

    // Content Section - Movie Details
    @IBOutlet weak var moviePosterImageView: CustomImageView!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var movieDetailsTitleLabel: UILabel!
    @IBOutlet weak var movieDetailsYearLabel: UILabel!
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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }

    // MARK: Privates:

    private func setupViews() {

        pillListView.addPillLabel("Action")
        pillListView.addPillLabel("Science Fiction")
        pillListView.addPillLabel("Adventure")
        pillListView.addPillLabel("Animation")
        pillListView.addPillLabel("Drama")
        pillListView.addPillLabel("Thriller")
        pillListView.addPillLabel("War")
    }
}
