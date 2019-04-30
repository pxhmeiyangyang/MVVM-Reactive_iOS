//
//  MRLoginVM.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/22.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

import ReactiveCocoa
import ReactiveSwift

/// 登录页面的viewModel
class MRLoginVM: MRBaseViewModel {

    /// 登录数据模型
    lazy var loginModel = {
        return MRLoginModel()
    }()
    
    var loginEnableProducer : SignalProducer<Bool,Never>!
    var loginActionPtoducer : SignalProducer<Bool,Never>!
    
    override init() {
        super.init()
    }
    
    override func initialBind() {
        let usernameProperty = DynamicProperty<String?>.init(object: loginModel, keyPath: #keyPath(MRLoginModel.username))
        let passwordProperty = DynamicProperty<String?>.init(object: loginModel, keyPath: #keyPath(MRLoginModel.password))
        loginEnableProducer = SignalProducer.combineLatest(usernameProperty, passwordProperty).map({ (username,password) -> Bool in
            return username?.count ?? 0 >= 5 && password?.count ?? 0 >= 5
        })
        loginActionPtoducer = SignalProducer<Bool,Never>.init({ [weak self] (observe,disposable) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                observe.send(value: true)
                observe.sendCompleted()
            })
        })
    }
    
}
