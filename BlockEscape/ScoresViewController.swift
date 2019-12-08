//
//  ScoresViewController.swift
//  BlockEscape
//
//  Created by Brooke Schoen on 11/15/19.
//  Copyright © 2019 DC Scott. All rights reserved.
//

import UIKit

class ScoresViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let scores = UserDefaults.standard.object(forKey: "scores") as? Array<Int> {
            print(scores)
        }
        
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
