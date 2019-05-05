//
//  MRTempObject.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/5/5.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

/// KVO 临时测试对象
class MRTempObject: NSObject {
    @objc dynamic var name: String?
    @objc dynamic var password: String?
}

class TempObject: NSObject {
    @objc dynamic var property: String?
}
