//
//  MRReactiveCocoaVC.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/5/5.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

/// Reactive cocoa view controller
class MRReactiveCocoaVC: MRBaseViewController {
    
    //    ReactiveCocoa开发中常见用法。
    //    代替代理:
    //      reactiveCocoa
    //    代替KVO :
    //      replaceKVO
    //    监听事件:
    //      listenEvent
    //    代替通知:
    //      replaceNotification
    //    监听文本框文字改变:
    //      textFieldChange
    /// 文本输入框
    lazy var textField: UITextField = {
        let view = UITextField()
        self.view.addSubview(view)
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    /// 按钮
    lazy var button: UIButton = {
        let view = UIButton(type: UIButton.ButtonType.custom)
        self.view.addSubview(view)
        view.setTitle("这是一个按钮", for: UIControl.State.normal)
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    
    /// view Model
    private let viewModel = MRReactiveCocoaVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func initialize() {
        self.title = "ReactiveCocoa"
    }
    
    override func bindingModel() {
        self.replaceDelegate()
        self.replaceKVO()
        self.listenEvent()
        self.replaceNotification()
        self.textFieldChange()
    }
    
    override func deploySubviews() {
        textField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(100)
            make.width.equalTo(100)
        }
        
        button.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(150)
        }
    }
    
    /// reactiveCocoa 替换 协议
    private func replaceDelegate(){
        let tap = UITapGestureRecognizer.init()
        self.view.addGestureRecognizer(tap)
        tap.reactive.stateChanged.observeValues {[weak self] (tap) in
            print("==========页面被点击了")
            self?.view.endEditing(true)
        }
    }
    
    /// reactiveCocoa 替换 key value observer
    private func replaceKVO(){
        let temp = MRTempObject()
        let test = DynamicProperty<String?>(object: temp,keyPath: "name")
        test.producer.startWithValues { (value) in
            print("===========value: \(value ?? "")")
        }
        let nameProperty = DynamicProperty<String?>(object: temp, keyPath: #keyPath(MRTempObject.name))
        nameProperty.producer.startWithValues { (name) in
            print("===========name: \(name ?? "")")
        }
        temp.name = "2"
        //        let temp = MRTempObject()
        //        temp.name = "1"
        //        temp = temp
        
        
        var tempObject = TempObject()
        let property = DynamicProperty<String?>(object: tempObject, keyPath: "property")
        property.producer.startWithValues { (value) in
            print("===========value: \(value ?? "")")
        }
        
        let property2 = DynamicProperty<String?>(object: tempObject, keyPath: #keyPath(TempObject.property))
        property2.producer.startWithValues { (value) in
            print("===========value: \(value ?? "")")
        }
        
        tempObject.property = "3"
        let test2 = TempObject()
        test2.property = "4"
        tempObject = test2
        
        var user = MRUser()
        let userNameProerpty = DynamicProperty<String?>(object: user, keyPath: #keyPath(MRUser.userName))
        userNameProerpty.producer.startWithValues { (value) in
            print("User's name is \(value ?? "")")
        }
        userNameProerpty.signal.observeValues { (value) in
            print("User's name is \(value ?? "")")
        }
        
        user.userName = "5"
        guard let tempUser = MRUser.deserialize(from: ["userName":"6"]) else { return }
        user = tempUser
    }
    
    /// 监听事件
    private func listenEvent(){
        button.reactive.controlEvents(UIControl.Event.touchUpInside).observeValues { (sender) in
            print("这是一个按钮点击了")
        }
    }
    
    /// 替代通知
    private func replaceNotification(){
        NotificationCenter.default.reactive.notifications(forName: UIApplication.didBecomeActiveNotification).observeValues { (noti: Notification) in
            print("UIApplication.didBecomeActiveNotification")
        }
    }
    
    /// 监听textField 内容变化
    private func textFieldChange(){
        textField.reactive.continuousTextValues.observeValues { (content) in
            print(content)
        }
    }
    
}

