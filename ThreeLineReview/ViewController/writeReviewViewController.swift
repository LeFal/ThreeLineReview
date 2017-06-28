//
//  writeReviewViewController.swift
//  ThreeLineReview
//
//  Created by LEOFALCON on 2017. 6. 28..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit
import Alamofire

class writeReviewViewController: UIViewController {
    @IBOutlet var targetName: UILabel!
    @IBOutlet var scoreTextfield: UITextField!
    @IBOutlet var reviewTextField: UITextField!

    var targetId : Int = 0
    var target : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        targetName.text = target
    }
    
    @IBAction func done(_ sender: Any) {
        let content = reviewTextField.text
        let score = Int(scoreTextfield.text!)
        let user = UserDefaults.standard.string(forKey: "id")
        postReview(content: content!, score: score!, user: user!, targetId: self.targetId)
    }
    
    fileprivate func postReview(content : String, score : Int, user : String, targetId : Int)  {
        let parameters: [String: Any] = [
            "content": content,
            "score": score,
            "user" : user,
            "target_id" : targetId
        ]
        Alamofire
            .request("http://localhost:8080/uploadReview.php", method : .post, parameters : parameters).responseString { response in
                print(response.value!)
                switch response.value! {
                case " success" :
                    self.dismiss(animated: true, completion: nil)
                default : print("error")
                }
        }
        return
    }
}
