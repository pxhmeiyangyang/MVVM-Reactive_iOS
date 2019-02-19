//
//  StdlibExtensions.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/19.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

extension String{
    public func stripSuffix(_ suffix: String)->String? {
        if let range = range(of: suffix) {
            return substring(with: startIndex ..< range.lowerBound)
        }
        return nil
    }
}
