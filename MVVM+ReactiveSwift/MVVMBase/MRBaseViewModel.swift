//
//  MRBaseViewModel.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/25.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

/// MVVM+ReactiveSwift 基础的viewModel
class MRBaseViewModel: NSObject,MRMVVMProtocol {
    
    override init() {
        super.init()
        loadAllProtocol()
    }
    
    func initialize() {
        
    }
    
    func deploySubviews() {
        
    }
    
    func bindingModel() {
        
    }
    
}
