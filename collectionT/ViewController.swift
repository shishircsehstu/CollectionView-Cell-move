//
//  ViewController.swift
//  collectionT
//
//  Created by shishir  on 12/7/20.
//  Copyright © 2020 shishir . All rights reserved.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation
class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images = [String]()
    var behavior = MSCollectionViewPeekingBehavior()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        /*
         behavior = MSCollectionViewPeekingBehavior(cellSpacing: 10)
         behavior = MSCollectionViewPeekingBehavior(cellPeekWidth: 20)
         //minimumItemsToScroll is the minimum number of items that can be scrolled
         behavior = MSCollectionViewPeekingBehavior(minimumItemsToScroll: 1)
         //maximumItemsToScroll is the maximum number of items that can be scrolled if the scroll distance is large
         behavior = MSCollectionViewPeekingBehavior(maximumItemsToScroll: 3)
         */
        
        
        // behavior = MSCollectionViewPeekingBehavior(maximumItemsToScroll: 5)
        
        behavior = MSCollectionViewPeekingBehavior(cellSpacing: 5)
        behavior = MSCollectionViewPeekingBehavior(cellPeekWidth: 15)
        images.append("1")
        images.append("2")
        
        images.append("3")
        images.append("4")
        images.append("5")
        images.append("1")
        images.append("2")
        
        images.append("3")
        images.append("4")
        images.append("5")
        
        collectionView.configureForPeekingBehavior(behavior: behavior)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "ImagCollectionViewCell", bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: "ImagCollectionViewCell")
        startTimer()
    }
    
    
    @objc func scrollAutomatically(){
        
        //get cell size
        let cellSize = CGSize(width: self.view.frame.width-25, height: self.view.frame.height);
        
        //get current content Offset of the Collection view
        let contentOffset = collectionView.contentOffset;
        
        if collectionView.contentSize.width <= collectionView.contentOffset.x + cellSize.width+25.0
        {
            collectionView.scrollRectToVisible(CGRect(x: 0, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);
            
        } else {
            
         
            collectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);
            
        }
        
        
    }
    
    @objc func scrollAutomatically2(_ timer1: Timer) {

        if let coll  = collectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)! < images.count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)

                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }

            }
        }
    }
    
    
    func startTimer() {
        _ =  Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }
}

extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagCollectionViewCell", for: indexPath) as! ImagCollectionViewCell
        
        cell.imageView.image = UIImage(named: images[indexPath.row])
        
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(behavior.currentIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        print(indexPath.item)
    }
    
}

