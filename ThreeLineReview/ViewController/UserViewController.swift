//
//  UserViewController.swift
//  ThreeLineReview
//
//  Created by LEOFALCON on 2017. 6. 27..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "id")
        if let gvc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginViewController {
            self.present(gvc, animated: false)
        }
    }
}
