//
//  HomeViewCell.swift
//  ThreeLineReview
//
//  Created by LEOFALCON on 2017. 5. 11..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell {

    @IBOutlet var RTImage: UIImageView!
    @IBOutlet var RTName: UILabel!
    @IBOutlet var RTCategory: UILabel!
    @IBOutlet var RTGoodValue: UILabel!
    @IBOutlet var RTSosoValue: UILabel!
    @IBOutlet var RTBadValue: UILabel!
    @IBOutlet var RTColorView: UIView!
    @IBOutlet var RTAverage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    fileprivate var reviewTarget : ReviewTarget?
    
    func config(reviewTarget : ReviewTarget) {
        self.backgroundColor = .gray
        
        //self.RTImage = reviewTarget.imageID
        self.reviewTarget = reviewTarget
        self.RTAverage.text = String(describing : reviewTarget.score)
        self.RTName.text = reviewTarget.name
        self.RTGoodValue.text = String(describing: reviewTarget.goodValue)
        self.RTSosoValue.text = String(describing: reviewTarget.sosoValue)
        self.RTBadValue.text = String(describing: reviewTarget.badValue)
        self.RTCategory.text = String(reviewTarget.categoryId)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
