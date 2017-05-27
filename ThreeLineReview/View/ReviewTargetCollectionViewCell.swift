//
//  ReviewTargetCollectionViewCell.swift
//  ThreeLineReview
//
//  Created by LEOFALCON on 2017. 5. 27..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit
import Kingfisher
import ManualLayout

class ReviewTargetCollectionViewCell: UICollectionViewCell {
    
    
    fileprivate let imageView = UIImageView()
    fileprivate let name = UILabel()
    fileprivate let category = UILabel()
    fileprivate let goodValue = UILabel()
    fileprivate let sosoValue = UILabel()
    fileprivate let badValue = UILabel()
    fileprivate let colorView = UIView()
    fileprivate let averageValue = UILabel()
    
    fileprivate let good = UILabel()
    fileprivate let soso = UILabel()
    fileprivate let bad = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.name)
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.category)
        self.contentView.addSubview(self.goodValue)
        self.contentView.addSubview(self.sosoValue)
        self.contentView.addSubview(self.badValue)
        self.contentView.addSubview(self.colorView)
        
        self.contentView.addSubview(self.good)
        self.contentView.addSubview(self.soso)
        self.contentView.addSubview(self.bad)
        self.contentView.addSubview(self.averageValue)
        
        
        self.good.text = "Good"
        self.soso.text = "Soso"
        self.bad.text = "Bad"
        
        self.imageView.backgroundColor = .blue
        self.name.numberOfLines = 1
        self.name.font = UIFont.systemFont(ofSize: 14)
        self.averageValue.font = UIFont.systemFont(ofSize : 14)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(reviewTarget : ReviewTarget) {
        self.backgroundColor = .gray
        self.name.text = reviewTarget.name
        self.category.text = String(reviewTarget.categoryId)
        self.colorView.backgroundColor = .yellow
        self.averageValue.text = String(describing: reviewTarget.score!)
        self.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.width = self.contentView.width
        self.imageView.height = self.imageView.width - 100
        
        self.contentView.bringSubview(toFront: self.name)
        self.contentView.bringSubview(toFront: self.category)
        self.contentView.bringSubview(toFront: self.colorView)
        self.contentView.bringSubview(toFront: self.averageValue)
        
        self.name.top = self.imageView.bottom - 80
        self.name.left = 10
        self.name.width = self.contentView.width - 20
        self.name.sizeToFit()
        
        self.category.top = self.name.bottom + 5
        self.category.left = self.name.left
        self.category.width = self.contentView.width - 20
        self.category.sizeToFit()
        
        self.colorView.width = 50
        self.colorView.height = 30
        self.colorView.right = self.imageView.right - 50
        self.colorView.centerY = self.name.centerY
        
        self.averageValue.centerX = self.colorView.centerX
        self.averageValue.centerY = self.name.centerY
        self.averageValue.sizeToFit()
        
        
    }
    
    class func size(width: CGFloat, reviewTarget: ReviewTarget) -> CGSize {
        var height: CGFloat = 0
        height += width // photoView height
        
        if let message = reviewTarget.name, !message.isEmpty {
            let font = UIFont.systemFont(ofSize: 14)
            let constraintSize = CGSize(width: width - 20, height: font.lineHeight * 3)
            let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
            let attributes: [String: Any] = [NSFontAttributeName: font]
            let boundingRect = message.boundingRect(
                with: constraintSize,
                options: options,
                attributes: attributes,
                context: nil
            )
            height += 10 // messageLabel top
            height += boundingRect.height // messageLabel height
            height += 10 // messageLabel bottom
        }
        return CGSize(width: width, height: height)
    }

}
