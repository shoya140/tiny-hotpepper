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
    var imageURLStrimg: String = ""
    var detailURLString: String = ""
    
    init(dict: [String:AnyObject]) {
        // TODO: refactoring 入れ子辞書の探索. もっといい方法があるはず.
        self.name = dict["name"] as! String
        
        let photo_ = dict["photo"] as! Dictionary<String, AnyObject>
        let pc_ = photo_["pc"] as! Dictionary<String, AnyObject>
        self.imageURLStrimg = pc_["l"] as! String
        
        let urls_ = dict["urls"] as! Dictionary<String, AnyObject>
        self.detailURLString = urls_["pc"] as! String
    }
}
