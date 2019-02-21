//
//  LoginExampleVM.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/21.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit
import Result
import ReactiveSwift
import ReactiveCocoa
/// Login 示例 view model
class LoginExampleVM {
    var dataModel = LoginModel()
    let usernameProperty: MutableProperty<String?>
    let passwordProperty: MutableProperty<String?>
    let logAction: Action<(),Bool,NoError>
    
    init() {
        usernameProperty = MutableProperty(dataModel.userName)
        passwordProperty = MutableProperty(dataModel.password)
        let validProperty = MutableProperty.combineLatest(usernameProperty, passwordProperty).map { (userName,password) -> Bool in
            return userName?.count ?? 0 >= 5 && password?.count ?? 0 >= 6
        }

        logAction = Action<(),Bool,NoError>(enabledIf: validProperty, execute: { _ in
            return SignalProducer{ observer,disposable in
                observer.send(value: true)
                observer.sendCompleted()
            }
        })
    }
}
