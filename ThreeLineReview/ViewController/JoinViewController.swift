//
//  JoinViewController.swift
//  ThreeLineReview
//
//  Created by LEOFALCON on 2017. 6. 27..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit
import Alamofire

class JoinViewController: UIViewController {
    @IBOutlet var idInsert: UITextField!
    @IBOutlet var passwordInsert: UITextField!
    @IBOutlet var nameInsert: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func join(_ sender: Any) {
        let email = idInsert.text
        let password = passwordInsert.text
        let name = nameInsert.text
        
        
        if !checkValidate(email: email, password: password, name: name) { return }
         fetchPosts(username: email!, password: password!, name: name!)
        }

    
    func checkValidate (email : String? , password : String?, name : String?) -> Bool {
        if !isValidEmail(testStr: email!){
            let alertController = UIAlertController(title: "오류", message: "이메일이 올바른 형식이 아닙니다.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return false
        }
        
        if (password?.characters.count)! < 8 || password?.characters.count == 0 {
            let alertController = UIAlertController(title: "오류", message: "페스워드가 올바르지 않습니다.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return false
        }
        if name?.characters.count == 0 {
            let alertController = UIAlertController(title: "오류", message: "닉네임이 올바르지 않습니다.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

    
    fileprivate func fetchPosts(
        username : String,
        password : String,
        name : String
        )  {
        let parameters: [String: Any] = [
            "login_email": username,
            "user_pw": password,
            "nickname" : name
            ]
        
        Alamofire
            .request("http://localhost:8080/join_ok_ios.php", method : .post, parameters : parameters).responseString { response in
                switch response.value! {
                case " overlapEmail" :
                    let alertController = UIAlertController(title: "오류", message: "중복된 이메일이 있습니다.", preferredStyle: .alert)
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


