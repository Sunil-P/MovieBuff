//
//  CollectionViewMovieTableCell.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/29/22.
//

import UIKit

class CollectionViewMovieTableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!

    var favoriteMovieButtonAction: ((_ tag: Int)->())?

    override func awakeFromNib() {

        super.awakeFromNib()

        backgroundView = BackgroundView()

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: UICollectionViewDataSource:

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.row < 3 {

            let cell = collectionView.dequeueReusableCell(

                withReuseIdentifier: "favoritesMovieCollectionCell", for: indexPath

            ) as! MovieCollectionCell

            cell.cellButton.tag = indexPath.row

            let image = UIImage(named: "samplePoster", in: Styles.frontendAppKitBundle, with: .none)!
            cell.cellButton.setImage(image, for: .normal)
            cell.cellButton.addTarget(self, action: #selector(moviePosterButtonClicked(_:)), for: .touchUpInside)

            return cell

        } else {

            let cell = collectionView.dequeueReusableCell(

                withReuseIdentifier: "favoritesSeeAllCollectionCell", for: indexPath

            ) as! SeeAllCollectionCell

            cell.cellButton.tag = indexPath.row

            cell.cellButton.addTarget(self, action: #selector(moviePosterButtonClicked(_:)), for: .touchUpInside)

            return cell
        }
    }

    @objc func moviePosterButtonClicked (_ sender:UIButton) {

        print("tag = \(sender.tag)")
        favoriteMovieButtonAction?(sender.tag)
        if sender.tag == 3 {

            print("See all button clicked")
        }
    }

} // CollectionViewMovieTableCell
