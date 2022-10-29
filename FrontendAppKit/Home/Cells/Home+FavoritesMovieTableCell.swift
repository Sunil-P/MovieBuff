//
//  Home+FavoritesMovieTableCell.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/29/22.
//

import UIKit

class Home_FavoritesMovieTableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

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

        let cell = collectionView.dequeueReusableCell(

            withReuseIdentifier: "favoritesMovieCollectionCell", for: indexPath

        ) as! Home_FavoritesMovieCollectionCell

        cell.moviePosterImage.image = UIImage(named: "samplePoster", in: Styles.frontendAppKitBundle, with: .none)

        return cell
    }
}
