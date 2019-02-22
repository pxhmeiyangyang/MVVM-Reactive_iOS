//
//  UserService.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/18.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit
import Result
import ReactiveSwift

class UserService {
    let (requestSignal, requestObserver) = Signal<String, NoError>.pipe()
    
    func canUseUsername(_ string : String)->SignalProducer<Bool, NoError>{
        return SignalProducer{ observer, disposable in
            self.requestObserver.send(value: string)
            observer.send(value: true)
            observer.sendCompleted()
        }
    }
    
}
