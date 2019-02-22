//
//  UIColor+MRExtension.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/22.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(rgbValue: UInt32) {
        self.init(red:CGFloat((rgbValue & 0xff0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0xff00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0xff) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgbaValue: UInt32) {
        self.init(red:CGFloat((rgbaValue & 0xff000000) >> 24) / 255.0, green: CGFloat((rgbaValue & 0xff0000) >> 16) / 255.0, blue: CGFloat((rgbaValue & 0xff00) >> 8) / 255.0, alpha: CGFloat(rgbaValue & 0xff) / 255.0)
    }
}

