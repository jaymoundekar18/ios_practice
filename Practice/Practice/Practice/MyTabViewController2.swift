//
//  MyTabViewController2.swift
//  Practice
//
//  Created by Chandra Hasan on 16/06/25.
//

import UIKit

class MyTabViewController2: UIViewController {

    @IBOutlet var dashboardIcon: UITabBarItem!
    
    @IBOutlet var firstCollection: UICollectionView!
    
    @IBOutlet var secondCollection: UICollectionView!
    
    let imgs1 = ["bicycle", "car", "cart", "shop","home"]
    let imgs2 = ["shop", "home", "cart", "car", "bicycle" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstCollection.delegate = self
        firstCollection.dataSource = self
        
        secondCollection.delegate = self
        secondCollection.dataSource = self
        // Do any additional setup after loading the view.
    }

}


extension MyTabViewController2: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if (collectionView == firstCollection){
            return 1
        }else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == firstCollection){
            return imgs1.count
        }else{
            return imgs2.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == firstCollection){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCell1", for: indexPath) as! DashboardCollectionViewCell1
            
            cell.upperImageView.image = UIImage(named: imgs1[indexPath.row])
            
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCell2", for: indexPath) as! DashboardCollectionViewCell2
            
            cell.lowerImageView.image = UIImage(named: imgs2[indexPath.row])
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 80, height: 80)
    }
}
