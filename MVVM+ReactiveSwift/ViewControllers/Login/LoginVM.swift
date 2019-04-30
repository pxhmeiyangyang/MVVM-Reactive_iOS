//
//  LoginVM.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/19.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

import ReactiveSwift
import ReactiveCocoa
/// 登录viewmodel
class LoginVM: NSObject {
    lazy var loginModel = {
        return LoginModel()
    }()
    
    var loginAction : Action<(),String,Error>! //登录活动
//    var enableProducer : SignalProducer<Bool, Never>!//信号生成器，登录按钮启用发送true，禁用发送false
    var userNameProperty : MutableProperty<String?>!
    var passwordProperty : MutableProperty<String?>!
    
    override init() {
        super.init()
        initialBind()
    }
    
    /// 绑定函数
    private func initialBind(){
        userNameProperty = MutableProperty(loginModel.userName)
        passwordProperty = MutableProperty(loginModel.password)
        let enableProducer = SignalProducer.combineLatest(userNameProperty.producer, passwordProperty.producer).map({ (account, password) -> Bool in
            return account?.count ?? 0 > 5 && password?.count ?? 0 > 5
        })
        
        let property = Property(initial: false, then: enableProducer)
        loginAction = Action<(),String,Error>(enabledIf: property){
            return SignalProducer{observer, disposable in
                observer.send(value: "登录成功")
                observer.sendCompleted()
            }
        }
    }
}
