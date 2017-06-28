//
//  UpdateReviewTargetViewController.swift
//  ThreeLineReview
//
//  Created by LEOFALCON on 2017. 6. 28..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit
import Alamofire

class UpdateReviewTargetViewController: UIViewController {
    @IBOutlet var target: UILabel!

    var targetId = 0
    var targetName = ""
    var basicInfo = ""
    
    @IBOutlet var BasicInfoTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        target.text = targetName
        BasicInfoTextField.text = basicInfo
    }
    
    @IBAction func update(_ sender: Any) {
        let info = BasicInfoTextField.text
        updatePostReviewTarget(targetId: self.targetId, basic_info: info!)
    }
    
    fileprivate func updatePostReviewTarget(targetId : Int,basic_info : String) {
        let parameters: [String: Any] = [
            "target_id": targetId,
            "basic_info" : basic_info
        ]
        Alamofire
            .request("http://localhost:8080/updateReview.php", method : .post, parameters : parameters).responseString { response in
                print(response.value!)
                switch response.value! {
                case " success" :
                    self.dismiss(animated: true, completion: nil)
                default : print("error")
                }
        }
    }


}
