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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        if section == 1 {
//
//            return "
//        }
//        return "Section \(section)"
//    }
    
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

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard section != 0 else {

            return nil
        }

        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))

        let regularTypography = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .medium)]
        let boldTypography = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .heavy)]

        let label = UILabel()
        label.frame = CGRect.init(x: 30, y: 0, width: headerView.frame.width, height: headerView.frame.height-10)
        label.font = .systemFont(ofSize: 12)
        label.textColor = Styles.ColorIds.highEmphasis
        headerView.addSubview(label)

        if section == 1 {

            let sectionHeaderString = NSMutableAttributedString(string:"YOUR", attributes: regularTypography)
            let suffixString = NSMutableAttributedString(string:" FAVORITES", attributes:boldTypography)
            sectionHeaderString.append(suffixString)

            label.attributedText = sectionHeaderString

        } else if section == 2 {

            let sectionHeaderString = NSMutableAttributedString(string:"OUR", attributes: regularTypography)
            let suffixString = NSMutableAttributedString(string:" STAFF PICKS", attributes:boldTypography)
            sectionHeaderString.append(suffixString)

            label.attributedText = sectionHeaderString
        }

        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0 {

            return 14

        } else if indexPath.section == 1 {

            return 300

        } else {

            return 150
        }
    }

//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//
//        if section == 0 {
//
//            return 0
//
//        } else {
//
//            return 14
//        }
//    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {

            let cell = tableView.dequeueReusableCell(withIdentifier: "searchButtonTableCell", for: indexPath)
            return cell

        } else if indexPath.section == 1 {

            let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesMovieTableCell", for: indexPath)

            if let favoritesMovieCell = cell as? Home_FavoritesMovieTableCell {

                
            }

            return cell

        } else {

            let cell = tableView.dequeueReusableCell(withIdentifier: "staffPickTableCell", for: indexPath)
            return cell
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} // Home_TableViewVC
