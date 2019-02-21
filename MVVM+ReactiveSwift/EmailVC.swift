//
//  EmailVC.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/18.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit
import Result
import ReactiveSwift
import ReactiveCocoa
import SnapKit
class EmailVC: UIViewController {
    
    private let emailField = UITextField()
    private let emailConfirmationField = UITextField()
    private let termsSwitch = UISwitch()
    private let reasonLabel = UILabel()
    private let submitButton = UIButton(type: .system)
    private let userService = UserService()
    private var viewModel : ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "邮箱校验"
        initialData()
        initialSubviews()
        bindModels()
        consoleMessages()
    }
    
    /// 初始化所有数据
    private func initialData(){
        viewModel = ViewModel.init(userService: userService)
    }
    
    /// 初始化所有的子view
    private func initialSubviews(){
        self.view.addSubview(emailField)
        emailField.borderStyle = .roundedRect
        emailField.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(30)
        }
        
        self.view.addSubview(emailConfirmationField)
        emailConfirmationField.borderStyle = .roundedRect
        emailConfirmationField.snp.makeConstraints { (make) in
            make.top.equalTo(emailField.snp.bottom).offset(50)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(30)
        }
        
        self.view.addSubview(termsSwitch)
        termsSwitch.snp.makeConstraints { (make) in
            make.top.equalTo(emailConfirmationField.snp.bottom).offset(50)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(30)
        }
        
        self.view.addSubview(reasonLabel)
        reasonLabel.backgroundColor = UIColor.brown
        reasonLabel.snp.makeConstraints { (make) in
            make.top.equalTo(termsSwitch.snp.bottom).offset(50)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(30)
        }
        
        self.view.addSubview(submitButton)
        submitButton.backgroundColor = UIColor.blue
        submitButton.setTitle("提交", for: UIControl.State.normal)
        submitButton.snp.makeConstraints { (make) in
            make.top.equalTo(reasonLabel.snp.bottom).offset(50)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(30)
        }
    }
    
    /// 绑定模型
    private func bindModels(){
        //initialize the interractive controls
        emailField.text = viewModel.email.value
        emailConfirmationField.text = viewModel.emailConfirmation.value
        termsSwitch.isOn = false
        //setup bindings with the interactive controls
        viewModel.email <~ emailField.reactive
            .continuousTextValues.skipNil()
        viewModel.emailConfirmation <~ emailConfirmationField.reactive.continuousTextValues.skipNil()
        viewModel.termsAccepted <~ termsSwitch.reactive.isOnValues
        // Setup bindings with the invalidation reason label.
        reasonLabel.reactive.text <~ viewModel.reasons
        //setup the Action binding with the submit button
        submitButton.reactive.pressed = CocoaAction(viewModel.submit)
    }
    
    /// userService messages
    private func consoleMessages(){
        
        userService.requestSignal.observeValues {
            print("UserService.requestSignal: Username `\($0)`.")
        }
        
        
        viewModel.submit.completed.observeValues {
            print("ViewModel.submit: execution producer has completed.\($0)")
        }
        
        viewModel.email.result.signal.observeValues {
            print("ViewModel.email: Validation result - \($0 != nil ? "\($0!)" : "No validation has ever been performed.")")
        }
        
        viewModel.emailConfirmation.result.signal.observeValues {
            print("ViewModel.emailConfirmation: Validation result - \($0 != nil ? "\($0!)" : "No validation has ever been performed.")")
        }
        
    }
}
