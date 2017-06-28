//
//  MakeReviewTargetViewController.swift
//  ThreeLineReview
//
//  Created by LEOFALCON on 2017. 6. 25..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit
import Alamofire

var categoryData =  [String:[String]]()

class MakeReviewTargetViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource  {

    @IBOutlet var targetName: UITextField!
    @IBOutlet var pickMiddleCategory: UIPickerView!
    @IBOutlet var pickCategory: UIPickerView!
    @IBOutlet var writeDefaultInfo: UITextView!
    @IBOutlet var writeScore: UITextField!
    @IBOutlet var writeReview: UITextView!
    var nowLargeCategory = "여행"
    var categoryData = [String:[String]]()
    var largeCategory = [String]()
    var middleCategory = [[String]]()
    var flag = 0
    var selectCategory = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        writeDefaultInfo.layer.borderColor = UIColor.black.cgColor
        writeDefaultInfo.layer.borderWidth = 1
        writeReview.layer.borderColor = UIColor.black.cgColor
        writeReview.layer.borderWidth = 1
        
        self.fetchCategory()

        print(categoryData)
        
        self.pickCategory.delegate = self
        self.pickCategory.dataSource = self
        self.pickMiddleCategory.delegate = self
        self.pickMiddleCategory.dataSource = self
        
        self.hideKeyboardWhenTappedAround()
    }
    
    fileprivate func fetchCategory() {
        Alamofire.request("http://localhost:8080/category.php").responseJSON { response in
            switch response.result {
            case .success(let value):
                guard let jsonData = value as? [String: [String]] else { return }
                self.categoryData = jsonData
                print(self.categoryData)
                
                self.largeCategory = Array(self.categoryData.keys)
                self.middleCategory = Array(self.categoryData.values)
                self.flag = 1

                self.pickCategory.reloadAllComponents()
                self.pickMiddleCategory.reloadAllComponents()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func saveReviewTarget(_ sender: Any) {
        let review = self.writeReview.text
        let score = Int(self.writeScore.text!)
        let defaultInfo = self.writeDefaultInfo.text
        let targetName = self.targetName.text
        let category = self.selectCategory
        let userEmail = UserDefaults.standard.string(forKey: "id")
        
        PostCategory(targetName: targetName!, category: category, defaultInfo: defaultInfo!, review: review!, score: score!, userID: userEmail!)
        
    }
    fileprivate func PostCategory(
        targetName : String,
        category : String,
        defaultInfo : String,
        review : String,
        score : Int,
        userID : String
        )  {
        let parameters: [String: Any] = [
            "name": targetName,
            "score": score,
            "category" : category,
            "basic_info" : defaultInfo,
            "create_user_id" : userID,
            "review" : review
        ]
        Alamofire
            .request("http://localhost:8080/uploadTarget.php", method : .post, parameters : parameters).responseString { response in
                print(response.value!)
                switch response.value! {
                case " success" :
//                    let alertController = UIAlertController(title: "업로드 성공", message: "정상적으로 업로드에 성공하였습니다.", preferredStyle: .alert)
//                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                    alertController.addAction(defaultAction)
//                    self.present(alertController, animated: true, completion: nil)
                    self.dismiss(animated: true, completion: nil)
                default : print("error")
                }
        }
        return
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickCategory {
            return categoryData.keys.count
        }
        if pickerView == pickMiddleCategory {
            if flag == 0 {
                return 0
            }
            else {
                return (categoryData[nowLargeCategory]?.count)!
            }
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickCategory {
            return self.largeCategory[row]
        }
        else if pickerView == pickMiddleCategory {
            return categoryData[nowLargeCategory]?[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickCategory {
            nowLargeCategory = self.largeCategory[row]
        }
        if pickerView == pickMiddleCategory {
            self.selectCategory = (categoryData[nowLargeCategory]?[row])!
        }
        self.pickMiddleCategory.reloadAllComponents()
    }
    

}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
