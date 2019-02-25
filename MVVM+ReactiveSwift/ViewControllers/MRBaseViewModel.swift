//
//  MRBaseViewModel.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/25.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

/// MVVM+ReactiveSwift
class MRBaseViewModel: NSObject {
    
    override init() {
        super.init()
        initialBind()
    }
    
    func initialBind(){}
}
