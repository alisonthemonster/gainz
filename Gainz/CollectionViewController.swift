//
//  CollectionViewController.swift
//  Gainz
//
//  Created by Alison on 4/21/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import Parse

class CollectionViewController: UICollectionViewController {

    private let reuseIdentifier = "badge"
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 25.0, right: 10.0)
    
    private var badgeValues:[Bool] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    private var badges:Badges = Badges()
    
    override func viewWillAppear(animated: Bool) {
        //get the badge values
        let query : PFQuery = PFUser.query()!
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                if let objects = objects {
                    let user = objects[0]
                    self.badgeValues = user["badges"] as! [Bool]
                    self.collectionView?.reloadData()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor(hue: 0.1333, saturation: 0, brightness: 1, alpha: 0.25)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.badges.count()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        
        // Get which data model element to use
        let index:Int = indexPath.row
        
        // Get the image for this cell
        let picture:Picture = self.badges.getPicture(index: index)
        //if unachieved
        if (!badgeValues[index]) {
            cell.image.image = picture.getGreyImage()
        } else {
            cell.image.image = picture.getImage()
        }
        cell.image.image! = imageResize(cell.image.image!, sizeChange: CGSize(width: 130, height: 130))

        return cell
    }
    
    func imageResize(imageObj:UIImage, sizeChange:CGSize)-> UIImage {
                let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, false, scale)
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext() // !!!
        return scaledImage
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            let size = 120
            return CGSizeMake(CGFloat(size), CGFloat(size))
    }
    
    // Returns the spacing between the cells, headers, and footers
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }

    
}
