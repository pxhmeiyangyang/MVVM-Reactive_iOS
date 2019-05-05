//
//  MRBaseViewController.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/22.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

/// 所有子VC的基础页面
class MRBaseViewController: UIViewController,MRMVVMProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllProtocol()
    }
    
    func initialize() {
        
    }
    
    func deploySubviews() {
        
    }
    
    func bindingModel() {
        
    }

}
