//
//  MRBaseViewController.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/22.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

class MRBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        bindModels()
    }
    
    /// 布局UI界面
    func layoutUI(){}
    
    /// 绑定模型
    func bindModels(){}

}
