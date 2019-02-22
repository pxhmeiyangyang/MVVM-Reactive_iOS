//
//  UIFont+MRExtension.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/22.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

enum SystemFontName: String {
    case Regular = ".PingFangSC-Regular"
    case Medium = ".PingFangSC-Medium"
}

extension UIFont{
    convenience init(fontName: SystemFontName, size: CGFloat) {
        self.init(name: fontName.rawValue, size: size)!
    }
    convenience init(fontName: SystemFontName) {
        self.init(name: fontName.rawValue, size: 17)!
    }
}
