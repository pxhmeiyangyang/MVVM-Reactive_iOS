//
//  MRReactiveCocoaVM.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/5/5.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

/// Reactive cocoa viewModel
class MRReactiveCocoaVM: MRBaseViewModel {
    
//    代替代理:
//    rac_signalForSelector：用于替代代理。
//    代替KVO :
//    rac_valuesAndChangesForKeyPath：用于监听某个对象的属性改变。
//    监听事件:
//    rac_signalForControlEvents：用于监听某个事件。
//    代替通知:
//    rac_addObserverForName:用于监听某个通知。
//    监听文本框文字改变:
//    rac_textSignal:只要文本框发出改变就会发出这个信号。
    
    /// 数据源 统一消息传递机制  KVO、Notification、delegation、block 以及 target-action 方式
    var datas = ["KVO","Notification","delegation","block","target-action"]
    
    override func initialize() {
        
    }
    
    override func bindingModel() {
        
    }
    
    override func deploySubviews() {
        
    }
}


