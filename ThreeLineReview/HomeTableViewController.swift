//
//  HomeTableViewController.swift
//  ThreeLineReview
//
//  Created by LEOFALCON on 2017. 5. 11..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit
import Alamofire

class HomeTableViewController: UITableViewController {

    var reviewTargets : [ReviewTarget] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchPosts()
    }
    
    fileprivate func fetchPosts() {
        Alamofire.request("http://localhost:8080/service.php").responseJSON { response in
            switch response.result {
                case .success(let value):
                    print(value)
                    guard let json = value as? [String: Any] else { return }
                    let reviewTargetsJSONArray = json["data"] as? [[String: Any]] ?? []
                    self.reviewTargets = [ReviewTarget](JSONArray: reviewTargetsJSONArray) ?? []
                    self.tableView.reloadData()
                case .failure(let error):
                print(error)
            }
        }
    }


    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewTargets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  Bundle.main.loadNibNamed("HomeViewCell", owner: nil, options: nil)?.first as! HomeViewCell
        cell.config(reviewTarget: reviewTargets[indexPath.row])


        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 211
    }
    
    


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
