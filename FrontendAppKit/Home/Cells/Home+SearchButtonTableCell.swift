//
//  Home+SearchButtonTableCell.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/29/22.
//

import UIKit

class Home_SearchButtonTableCell: UITableViewCell {

    @IBOutlet weak var searchButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        searchButton.addTarget(self, action: #selector(searchButtonClicked(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc func searchButtonClicked (_ sender:UIButton) {

        if sender == self {

            print("SDSeSD")
        }
    }

} // Home_SearchButtonTableCell
