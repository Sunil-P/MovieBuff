//
//  SearchViewController.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/3/22.
//

import UIKit

class SearchViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!

    @IBOutlet weak var ratingCollectionView: UICollectionView!
    @IBAction func backButtonAction(_ sender: UIButton) {

        self.dismiss(animated: true)
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search all movies",
            attributes: [NSAttributedString.Key.foregroundColor: Styles.ColorIds.lowEmphasisLight]
        )
        ratingCollectionView.delegate = self
        ratingCollectionView.dataSource = self
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {

        .darkContent
    }

    // MARK: UICollectionViewDelegateFlowLayout

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

    // MARK: UICollectionViewDataSource:

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(

            withReuseIdentifier: "ratingButtonCollectionCell", for: indexPath

        ) as! Search_RatingCollectionCell

        cell.ratingButton.rating = 5-indexPath.row
        cell.handleAction = {

            print("Rating button clicked")
            // handle rating button model click
        }

        return cell
    }


}
