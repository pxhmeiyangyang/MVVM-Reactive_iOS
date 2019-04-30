//
//  UserService.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/18.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

import ReactiveSwift

class UserService {
    let (requestSignal, requestObserver) = Signal<String, Never>.pipe()
    
    func canUseUsername(_ string : String)->SignalProducer<Bool, Never>{
        return SignalProducer{ observer, disposable in
            self.requestObserver.send(value: string)
            observer.send(value: true)
            observer.sendCompleted()
        }
    }
    
}
