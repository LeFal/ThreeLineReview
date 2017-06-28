//
//  SearchViewController.swift
//  ThreeLineReview
//
//  Created by LEOFALCON on 2017. 6. 28..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet var searchBar: UITextField!
    @IBOutlet var collectionView: UICollectionView!
    var reviewTargets : [ReviewTarget] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.collectionView.frame = self.view.bounds
        self.collectionView.backgroundColor = .lightGray
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        //self.collectionView.frame = self.view.bounds
        self.collectionView.register(UINib(nibName: "ReviewTargetCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "searchTarget")

        // Do any additional setup after loading the view.
    }

    @IBAction func search(_ sender: Any) {
        let keyword = searchBar.text
        fetchSearches(keyword: keyword!)
        self.collectionView.reloadData()
    }
    
    
    fileprivate func fetchSearches(keyword : String) {
        let parameters: [String: Any] = [
            "search": keyword
        ]
        Alamofire
            .request("http://localhost:8080/search.php", method : .post, parameters : parameters).responseJSON { response in
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

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.reviewTargets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchTarget", for: indexPath) as! ReviewTargetCollectionViewCell
        cell.config(reviewTarget: self.reviewTargets[indexPath.item])
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width
        return ReviewTargetCollectionViewCell.size(width: cellWidth, reviewTarget: self.reviewTargets[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let uvc = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as?
            DetailPageViewController {
            uvc.reviewTarget.removeAll()
            uvc.reviewTarget.append(reviewTargets[indexPath.item])
            self.navigationController?.pushViewController(uvc, animated: true)
        }
        
    }

    


}
