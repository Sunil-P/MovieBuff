//
//  Home+TableView+VC.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/29/22.
//

import UIKit

class Home_TableViewVC: UITableViewController {

    override func viewDidLoad() {

        super.viewDidLoad()

        var frame = UIScreen.main.bounds
        frame.origin.y = -frame.size.height

        let bounceView = UIView(frame: frame)
        bounceView.backgroundColor = .white

        self.view.addSubview(bounceView)

        tableView.backgroundColor = Styles.ColorIds.highEmphasis
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 || section == 1 {

            return 1

        } else {

            return 5
        }
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        let view = UIView()

        if section > 0 {

            view.backgroundColor = Styles.ColorIds.highEmphasis

        } else {

            view.backgroundColor = .white
        }

        return view
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard section != 0 else {

            let view = UIView()

            view.backgroundColor = .white

            return view
        }

        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))

        let label = UILabel()
        label.frame = CGRect.init(x: 30, y: 0, width: headerView.frame.width, height: headerView.frame.height-10)
        label.font = .systemFont(ofSize: 12)
        label.textColor = Styles.ColorIds.highEmphasis
        headerView.addSubview(label)
        headerView.backgroundColor = .white

        if section == 1 {

            let sectionHeaderString = NSMutableAttributedString(

                string:"YOUR",
                attributes: Styles.AttributedTypography.regularTypographyLight
            )
            let suffixString = NSMutableAttributedString(

                string:" FAVORITES",
                attributes:Styles.AttributedTypography.boldTypographyLight
            )

            sectionHeaderString.append(suffixString)
            label.attributedText = sectionHeaderString

        } else if section == 2 {

            let sectionHeaderString = NSMutableAttributedString(

                string:"OUR",
                attributes: Styles.AttributedTypography.regularTypographyDark
            )
            let suffixString = NSMutableAttributedString(

                string:" STAFF PICKS",
                attributes: Styles.AttributedTypography.boldTypographyDark
            )

            sectionHeaderString.append(suffixString)
            label.attributedText = sectionHeaderString

            headerView.backgroundColor = Styles.ColorIds.highEmphasis
        }

        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0 {

            return 80

        } else if indexPath.section == 1 {

            return 300

        } else {

            return 150
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {

            let cell = tableView.dequeueReusableCell(withIdentifier: "searchButtonTableCell", for: indexPath)

            if let searchButtonCell = cell as? SearchButtonTableCell {

                searchButtonCell.searchButton.tag = indexPath.row
                searchButtonCell.searchButton.addTarget(self, action: #selector(searchButtonClicked(_:)), for: .touchUpInside)
            }

            return cell

        } else if indexPath.section == 1 {

            let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesMovieTableCell", for: indexPath)

            if let favoritesMovieCell = cell as? CollectionViewMovieTableCell {

                favoritesMovieCell.favoriteMovieButtonAction = { [weak self] tag in

                    self?.favouriteMovieClicked(tag: tag)
                }
            }

            return cell

        } else {

            let cell = tableView.dequeueReusableCell(withIdentifier: "staffPickTableCell", for: indexPath)

            if indexPath.row != 0 {

                let separatorView = UIView(frame: CGRect(x: 30, y:0, width: tableView.frame.width-60, height: 1))
                separatorView.backgroundColor = .black

                cell.addSubview(separatorView)
            }

            return cell
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "searchButtonSegue" {

            let _ = segue.destination as! SearchViewController
            // Do something
        }
    }

    @objc func searchButtonClicked (_ sender:UIButton) {

        print("Search button clicked")

        performSegue(withIdentifier: "searchButtonSegue", sender: self)
    }

    func favouriteMovieClicked(tag: Int) {

        print("Segue to fav movie with tag: \(tag)")
    }

} // Home_TableViewVC
