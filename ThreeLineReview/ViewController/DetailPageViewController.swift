//
//  DetailPageViewController.swift
//  ThreeLineReview
//
//  Created by LEOFALCON on 2017. 6. 28..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class DetailPageViewController: UIViewController {
    
    var reviewTarget : [ReviewTarget] = []
    @IBOutlet var name: UILabel!
    @IBOutlet var avgValue: UILabel!
    @IBOutlet var goodValue: UILabel!
    @IBOutlet var sosoValue: UILabel!
    @IBOutlet var badValue: UILabel!
    @IBOutlet var basicInfo: UILabel!
    @IBOutlet var reviewCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.text = reviewTarget[0].name!
        self.goodValue.text = String(describing: reviewTarget[0].goodValue!)
        self.sosoValue.text = String(describing: reviewTarget[0].sosoValue!)
        self.badValue.text = String(describing: reviewTarget[0].badValue!)
        self.basicInfo.text = reviewTarget[0].basicInfo!
        self.reviewCount.text = String(describing: reviewTarget[0].reviewCount!)
        self.avgValue.text = String(describing: reviewTarget[0].score!)
    }
}
