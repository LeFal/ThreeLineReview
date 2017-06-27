//
//  CollectionViewCell.swift
//  ThreeLineReview
//
//  Created by LEOFALCON on 2017. 5. 28..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class ReviewTargetCollectionViewCell: UICollectionViewCell {

    @IBOutlet var name: UILabel!
    @IBOutlet var category: UILabel!
    @IBOutlet var sosoValue: UILabel!
    @IBOutlet var goodValue: UILabel!
    @IBOutlet var badValue: UILabel!
    @IBOutlet var colorView: UIView!
    @IBOutlet var averageValue: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.backgroundColor = .blue
    }
    
    
    func config(reviewTarget : ReviewTarget) {
        self.backgroundColor = .white
        
        self.name.text = reviewTarget.name
        self.category.text = String(reviewTarget.categoryId)
        self.averageValue.text = String(describing: reviewTarget.score!)
        self.goodValue.text = String(describing: reviewTarget.goodValue!)
        self.sosoValue.text = String(describing: reviewTarget.sosoValue!)
        self.badValue.text = String(describing: reviewTarget.badValue!)
        
        self.colorView.backgroundColor = .white
        self.averageValue.backgroundColor = .red
        
        self.setNeedsLayout()
    }
    
    func getColor(average : Int) -> UIColor {
        switch average {
        case 0...3:
            return .red
        case 4...7:
            return .green
        case 8...10:
            return .blue
        default:
            return .gray
        }
    }
    
    
    
    class func size(width: CGFloat, reviewTarget: ReviewTarget) -> CGSize {
        var height: CGFloat = 0
            height += 160 // imageView height
            height += 12 // Value Label top
            height += 14.5 // Value Label
            height += 12 // Value Label bottom
        return CGSize(width: width, height: height)
    }
}
