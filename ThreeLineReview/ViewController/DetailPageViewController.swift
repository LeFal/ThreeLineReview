//
//  DetailPageViewController.swift
//  ThreeLineReview
//
//  Created by LEOFALCON on 2017. 6. 28..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit
import Alamofire

class reviewCell: UITableViewCell {
    @IBOutlet var writer: UILabel!
    @IBOutlet var createDate: UILabel!
    @IBOutlet var score: UILabel!
    @IBOutlet var content: UILabel!
    @IBOutlet var deleteReview: UIButton!
}


class DetailPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var reviewTarget : [ReviewTarget] = []
    var reviews : [Review]  = []
    @IBOutlet var name: UILabel!
    @IBOutlet var avgValue: UILabel!
    @IBOutlet var goodValue: UILabel!
    @IBOutlet var sosoValue: UILabel!
    @IBOutlet var badValue: UILabel!
    @IBOutlet var basicInfo: UILabel!
    @IBOutlet var reviewCount: UILabel!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.name.text = reviewTarget[0].name!
        self.goodValue.text = String(describing: reviewTarget[0].goodValue!)
        self.sosoValue.text = String(describing: reviewTarget[0].sosoValue!)
        self.badValue.text = String(describing: reviewTarget[0].badValue!)
        self.basicInfo.text = reviewTarget[0].basicInfo!
        self.reviewCount.text = String(describing: reviewTarget[0].reviewCount!)
        self.avgValue.text = String(describing: reviewTarget[0].score!)
        self.basicInfo.sizeToFit()
        self.fetchReviews(targetId: reviewTarget[0].id)
        self.deleteReviewTarget.isHidden = true
        if UserDefaults.standard.string(forKey: "id") == "admin@admin.com"{
            self.deleteReviewTarget.isHidden = false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchPosts()
        self.fetchReviews(targetId: reviewTarget[0].id)
        self.tableView.reloadData()

    }
    
    func setData()  {
        self.name.text = reviewTarget[0].name!
        self.goodValue.text = String(describing: reviewTarget[0].goodValue!)
        self.sosoValue.text = String(describing: reviewTarget[0].sosoValue!)
        self.badValue.text = String(describing: reviewTarget[0].badValue!)
        self.basicInfo.text = reviewTarget[0].basicInfo!
        self.reviewCount.text = String(describing: reviewTarget[0].reviewCount!)
        self.avgValue.text = String(describing: reviewTarget[0].score!)

    }
    
    
    
    @IBAction func writeReview(_ sender: Any) {
        if let uvc = self.storyboard?.instantiateViewController(withIdentifier: "writeReviewVC") as?
            writeReviewViewController {
            uvc.targetId = reviewTarget[0].id
            uvc.target = reviewTarget[0].name!
            self.present(uvc, animated: true, completion: nil)
        }

    }
    @IBAction func updateBasicInfo(_ sender: Any) {
        if let uvc = self.storyboard?.instantiateViewController(withIdentifier: "updateReviewTargetVC") as?
            UpdateReviewTargetViewController {
            uvc.targetId = reviewTarget[0].id
            uvc.targetName = reviewTarget[0].name!
            uvc.basicInfo = reviewTarget[0].basicInfo!
            self.present(uvc, animated: true, completion: nil)
        }

    }
    @IBOutlet var deleteReviewTarget: UIButton!
    @IBAction func deleteReviewTarget(_ sender: Any) {
        deletePostReviewTarget(targetId: reviewTarget[0].id)
    }
    
    fileprivate func deletePostReviewTarget(targetId : Int) {
        let parameters: [String: Any] = [
            "target_id": targetId
        ]
        Alamofire
            .request("http://localhost:8080/deleteReview.php", method : .post, parameters : parameters).responseString { response in
                switch response.value! {
                case " success" :
                    _ = self.navigationController?.popViewController(animated: true)
                default : print("error")
                }
        }
    }

    fileprivate func fetchPosts() {
        Alamofire.request("http://localhost:8080/service.php").responseJSON { response in
            switch response.result {
            case .success(let value):
                guard let json = value as? [String: Any] else { return }
                let reviewTargetsJSONArray = json["data"] as? [[String: Any]] ?? []
                reviewTargets = [ReviewTarget](JSONArray: reviewTargetsJSONArray) ?? []
                self.setData()
            case .failure(let error):
                print(error)
            }
        }
    }

    
    fileprivate func fetchReviews(targetId : Int) {
        let parameters: [String: Any] = [
            "target_id": targetId
        ]
        Alamofire
            .request("http://localhost:8080/getReview.php", method : .post, parameters : parameters).responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard let json = value as? [String: Any] else { return }
                    let reviewsJSONArray = json["data"] as? [[String: Any]] ?? []
                    self.reviews = [Review](JSONArray: reviewsJSONArray) ?? []
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! reviewCell
        cell.content.text = reviews[indexPath.row].content
        cell.createDate.text = String(describing: reviews[indexPath.row].inputDate!)
        cell.writer.text = reviews[indexPath.row].writer
        cell.score.text = String(describing: reviews[indexPath.row].score!)
        cell.deleteReview.isHidden = true
        if UserDefaults.standard.string(forKey: "id") == "admin@admin.com"{
            cell.deleteReview.isHidden = false
        }

        return cell
    }
    
}
