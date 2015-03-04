//
//  THResultViewController.swift
//  tiny-hotpepper
//
//  Created by ishimaru on 2015/03/03.
//  Copyright (c) 2015 shoya140. All rights reserved.
//

import UIKit
import AFNetworking
import SDWebImage

private let GOURMET_SEARCH_URL = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/"
private let API_KEY = "RECRUIT_WEB_API_KEY"

class THResultViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var keyword: String = ""
    var latitude: Float = 0.0
    var longtitude: Float = 0.0
    
    var shops: Array<THShop> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "検索結果"
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let params: Dictionary<String, String> = [
            "key":API_KEY,
            "format":"json",
            "is_open_time":"now",
            "keyword":self.keyword,
            "lat":String(format: "%.2f", self.latitude),
            "lng":String(format: "%.2f", self.longtitude),
            "range":"5",
            "order":"4",
            "start":"1"
        ]
        
        var manager = AFHTTPRequestOperationManager()
        manager.GET(
            GOURMET_SEARCH_URL,
            parameters: params,
            success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
                // TODO: refactoring 入れ子辞書の探索. もっといい方法があるはず.
                let response = responseObject as! Dictionary<String, AnyObject>
                let results_ = response["results"] as! Dictionary<String, AnyObject>
                if let items = results_["shop"] as? Array<Dictionary<String, AnyObject>> {
                    for item in items {
                        self.shops.append(THShop(dict:item))
                    }
                    self.collectionView.reloadData()
                }else{
                    NSLog("検索結果0件です")
                }
            }, failure: { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                NSLog("error: \(error)")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shops.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! THResultCell
        let shop = shops[indexPath.row]
        cell.nameLabel.text = shop.name
        cell.imageView.sd_setImageWithURL(
            NSURL(string: shop.imageURLStrimg),
            completed: { (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, imageURL: NSURL!) -> Void in
                if cacheType != SDImageCacheType.Memory {
                    UIView.transitionWithView(cell.imageView, duration: 0.28, options:UIViewAnimationOptions.TransitionCrossDissolve | UIViewAnimationOptions.CurveLinear | UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                        // pass
                    }, completion: { (Bool) -> Void in
                        // pass
                    })
                }
        })
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("THDetailViewController") as! THDetailViewController
        detailVC.shop = self.shops[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenSize = UIScreen.mainScreen().bounds
        let space: CGFloat = 10.0
        return CGSizeMake((screenSize.size.width - space * 3)/2, (screenSize.size.width - space * 3)/2)
    }
}