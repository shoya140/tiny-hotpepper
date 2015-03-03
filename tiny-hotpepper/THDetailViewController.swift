//
//  THDetailViewController.swift
//  tiny-hotpepper
//
//  Created by ishimaru on 2015/03/03.
//  Copyright (c) 2015 shoya140. All rights reserved.
//

import UIKit

class THDetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var shop: THShop!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.shop.name
        let request = NSURLRequest(URL: NSURL(string: self.shop.detailURLString)!)
        self.webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
