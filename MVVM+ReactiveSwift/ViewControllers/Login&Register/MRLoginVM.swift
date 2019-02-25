//
//  MRLoginVM.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/22.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit
import Result
import ReactiveCocoa
import ReactiveSwift

/// 登录页面的viewModel
class MRLoginVM: MRBaseViewModel {

    let loginModel = MRLoginModel()
    var loginEnableProducer : SignalProducer<Bool,NoError>!
    var loginActionPtoducer : SignalProducer<Bool,NoError>!
    
    override init() {
        super.init()
    }
    
    override func initialBind() {
        let usernameProperty = DynamicProperty<String?>.init(object: loginModel, keyPath: #keyPath(MRLoginModel.username))
        let passwordProperty = DynamicProperty<String?>.init(object: loginModel, keyPath: #keyPath(MRLoginModel.password))
        loginEnableProducer = SignalProducer.combineLatest(usernameProperty, passwordProperty).map({ (username,password) -> Bool in
            return username?.count ?? 0 >= 5 && password?.count ?? 0 >= 5
        })
        loginActionPtoducer = SignalProducer<Bool,NoError>.init({ [weak self] (observe,disposable) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                observe.send(value: true)
                observe.sendCompleted()
            })
        })
    }
    
}
