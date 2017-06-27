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
