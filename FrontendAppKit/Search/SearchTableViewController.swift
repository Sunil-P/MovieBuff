//
//  SearchTableViewController.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/28/22.
//

import UIKit

class SearchTableViewController: UITableViewController {

    let data = ["Special", "Lightyear", "Inception", "The Dark Knight", "The Dark Knight", "The Dark Knight", "The Dark Knight"]
    var filteredData: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()

//        searchBar.delegate = self
        filteredData = data

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        150
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return filteredData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell")! as UITableViewCell

        if indexPath.row > 0 {

            let separatorView = UIView(frame: CGRect(x: 30, y:0, width: tableView.frame.width - 60, height: 1))
            separatorView.backgroundColor = Styles.ColorIds.lowEmphasisLight

            cell.addSubview(separatorView)
        }

        return cell
    }

//    // MARK: UISearchBarDelegate
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        filteredData = []
//
//        if searchText.isEmpty {
//
//            filteredData = data
//
//        } else {
//
//            filteredData = data.filter {
//
//                let isAvailable = $0.lowercased().contains(searchText.lowercased())
//
//                return isAvailable
//            }
//        }
//
//        self.tableView.reloadData()
//    }

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

} // SearchViewController
