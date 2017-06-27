//
//  LoginViewController.swift
//  ThreeLineReview
//
//  Created by LEOFALCON on 2017. 6. 27..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    @IBAction func login(_ sender: Any) {
        let email = self.email.text
        let password = self.password.text
        
        fetchPosts(username: email!, password: password!)
        
    }
    fileprivate func fetchPosts(
        username : String,
        password : String
        )  {
        let parameters: [String: Any] = [
            "login_email": username,
            "user_pw": password
        ]
        
        Alamofire
            .request("http://localhost:8080/login_ok_ios.php", method : .post, parameters : parameters).responseString { response in
                print(response.value!)
                switch response.value! {
                case " NoEmail" :
                    let alertController = UIAlertController(title: "오류", message: "일치하는 이메일이 없습니다.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                case "IncorrectPassword" :
                    let alertController = UIAlertController(title: "오류", message: "비밀번호가 일치하지 않습니다.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                case " success" :
                    UserDefaults.standard.set(username, forKey: "id")
                    if let gvc = self.storyboard?.instantiateViewController(withIdentifier: "mainVC") as? UITabBarController {
                        self.present(gvc, animated: false)
                    }
                default : print("error")
                }
        }
        return
    }
}
