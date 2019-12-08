//
//  ScoresViewController.swift
//  BlockEscape
//
//  Created by Brooke Schoen on 11/15/19.
//  Copyright © 2019 DC Scott. All rights reserved.
//
//  SOURCES: https://www.codementor.io/brettr/two-basic-ways-to-populate-your-uitableview-du107rsyx
//           https://stackoverflow.com/questions/40415223/numberofsectionsintableview-not-working

import UIKit

class ScoresViewController: UITableViewController {

    var scores = UserDefaults.standard.object(forKey: "scores") as! Array<Int>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scores.sort(by: >)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
        cell.textLabel?.text = String(scores[indexPath.item])
        return cell
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
