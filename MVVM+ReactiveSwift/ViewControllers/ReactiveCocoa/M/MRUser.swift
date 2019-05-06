//
//  MRUser.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/5/6.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit
import HandyJSON
/// 用户模型
@objcMembers
class MRUser: NSObject,HandyJSON {
    dynamic var userName: String?
    dynamic var email: String?
    dynamic var address: String?
    
    override required init() {}
}
