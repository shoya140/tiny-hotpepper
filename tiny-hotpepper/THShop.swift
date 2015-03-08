//
//  THShop.swift
//  tiny-hotpepper
//
//  Created by ishimaru on 2015/03/03.
//  Copyright (c) 2015 shoya140. All rights reserved.
//

import UIKit

class THShop: NSObject {
    var name: String = ""
    var imageURLString: String = ""
    var detailURLString: String = ""
    
    init(dict: [String:AnyObject]) {
        let shopDict = NSDictionary(dictionary: dict)
        let dict_:Dictionary<String, AnyObject> = shopDict as! Dictionary<String, AnyObject>
        self.name = shopDict.valueForKeyPath("name") as! String
        self.imageURLString = shopDict.valueForKeyPath("photo.pc.l") as! String
        self.detailURLString = shopDict.valueForKeyPath("urls.pc") as! String
    }
}
