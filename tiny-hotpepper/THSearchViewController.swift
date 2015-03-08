//
//  THSearchViewController.swift
//  tiny-hotpepper
//
//  Created by ishimaru on 2015/03/03.
//  Copyright (c) 2015 shoya140. All rights reserved.
//

import UIKit
import FlatUIKit
import CoreLocation

class THSearchViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var searchButton: FUIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    var latitude: Float = 0.0
    var longtitude: Float = 0.0
    var manager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Tiny Hotpepper"
        self.searchTextField.delegate = self
        self.searchButton.setTitle("検索", forState: UIControlState.Normal)
        self.searchButton.buttonColor = UIColor.alizarinColor()
        self.searchButton.shadowColor = UIColor.pomegranateColor()
        self.searchButton.shadowHeight = 3.0
        self.searchButton.cornerRadius = 6.0
        self.searchButton.titleLabel?.font = UIFont.boldFlatFontOfSize(16)
        self.searchButton.setTitleColor(UIColor.cloudsColor(), forState: UIControlState.Normal)
        self.searchButton.setTitleColor(UIColor.cloudsColor(), forState: UIControlState.Highlighted)
        
        latitude = 0.0
        longtitude = 0.0
        
        manager = CLLocationManager()
        manager.delegate = self
        if manager.respondsToSelector("requestWhenInUseAuthorization") {
            manager.requestWhenInUseAuthorization()
        }
        manager.startUpdatingLocation()
        
    }
    
    func searchShop() {
        if count(self.searchTextField.text) == 0 {
            var alert: UIAlertController = UIAlertController(title: "キーワードが空欄のままです", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            let cancel: UIAlertAction = UIAlertAction(title: "入力する", style: UIAlertActionStyle.Cancel, handler:nil)
            alert.addAction(cancel)
            presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        if latitude == 0.0 {
            var alert: UIAlertController = UIAlertController(title: "現在の位置を取得できません", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            let tokyo: UIAlertAction = UIAlertAction(title: "とりあえず東京駅周辺を検索", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                //TODO: refactoring resultVCへの遷移をここにも書くの冗長
                var resultVC = self.storyboard?.instantiateViewControllerWithIdentifier("THResultViewController") as! THResultViewController
                resultVC.keyword = self.searchTextField.text
                resultVC.latitude = 35.681
                resultVC.longtitude = 139.766
                self.navigationController?.pushViewController(resultVC, animated: true)
            })
            let cancel: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.Cancel, handler:{ (action:UIAlertAction!) -> Void in
                return
            })
            alert.addAction(tokyo)
            alert.addAction(cancel)
            presentViewController(alert, animated: true, completion: nil)
        }
        
        var resultVC = self.storyboard?.instantiateViewControllerWithIdentifier("THResultViewController") as! THResultViewController
        resultVC.keyword = self.searchTextField.text
        resultVC.latitude = latitude
        resultVC.longtitude = longtitude
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
    
    @IBAction func searchButtonWasPushed(sender: AnyObject) {
        searchShop()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField .resignFirstResponder()
        self.searchShop()
        return true
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        latitude = Float(manager.location.coordinate.latitude)
        longtitude = Float(manager.location.coordinate.longitude)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
