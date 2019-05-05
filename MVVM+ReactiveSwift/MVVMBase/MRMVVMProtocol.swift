//
//  MRMVVMProtocol.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/5/5.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

/// MVVM 协议
public protocol MRMVVMProtocol{
    
    /// 加载所有协议方法
    func loadAllProtocol()
    
    /// 初始化协议方法
    func initialize()
    
    /// 绑定模型协议方法
    func bindingModel()
    
    /// 配置界面子view
    func deploySubviews()
}

// MARK: - MRMVVM协议拓展
extension MRMVVMProtocol{
    func loadAllProtocol(){
        self.initialize()
        self.bindingModel()
        self.deploySubviews()
    }
}
