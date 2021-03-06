//
//  HomeViewController.swift
//  ThreeLineReview
//
//  Created by LEOFALCON on 2017. 5. 24..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var reviewTargets : [ReviewTarget] = []
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.collectionView.frame = self.view.bounds
        self.collectionView.backgroundColor = .lightGray
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.frame = self.view.bounds
        self.view.addSubview(self.collectionView)
        self.collectionView.register(UINib(nibName: "ReviewTargetCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "reviewTarget")

        self.fetchPosts()
    }

    fileprivate func fetchPosts() {
        Alamofire.request("http://localhost:8080/service.php").responseJSON { response in
            switch response.result {
            case .success(let value):
                guard let json = value as? [String: Any] else { return }
                let reviewTargetsJSONArray = json["data"] as? [[String: Any]] ?? []
                self.reviewTargets = [ReviewTarget](JSONArray: reviewTargetsJSONArray) ?? []
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.reviewTargets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewTarget", for: indexPath) as! ReviewTargetCollectionViewCell
        cell.config(reviewTarget: self.reviewTargets[indexPath.item])
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width
        return ReviewTargetCollectionViewCell.size(width: cellWidth, reviewTarget: self.reviewTargets[indexPath.item])

    }
    

    
}
