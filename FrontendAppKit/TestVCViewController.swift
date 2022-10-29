//
//  TestVCViewController.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/29/22.
//

import UIKit

class TestVCViewController: UIViewController {

    @IBOutlet weak var switchBtn: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = Blocks.FavoritesButton(frame: .init(x: 100, y: 100, width: 50, height: 50))
        self.view.addSubview(button)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
