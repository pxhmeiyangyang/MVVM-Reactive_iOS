//
//  LoginExampleVC.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/21.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit
import Result
import ReactiveCocoa
import ReactiveSwift

/// login 示例view controller
class LoginExampleVC: UIViewController {

    private let usernameTF = UITextField()
    private let passwordTF = UITextField()
    private let submitBtn = UIButton(type: UIButton.ButtonType.system)
    private let viewModel = LoginExampleVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deploySubviews()
        bindModels()
        consoleMessages()
    }

    /// 配置所有的子view
    private func deploySubviews(){
        self.view.addSubview(usernameTF)
        usernameTF.placeholder = "请输入账号"
        usernameTF.borderStyle = .roundedRect
        usernameTF.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(44)
        }
        
        self.view.addSubview(passwordTF)
        passwordTF.placeholder = "请输入密码"
        passwordTF.borderStyle = .roundedRect
        passwordTF.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTF.snp.bottom).offset(50)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(44)
        }
        
        self.view.addSubview(submitBtn)
        submitBtn.setTitle("submit", for: UIControl.State.normal)
        submitBtn.backgroundColor = UIColor.blue
        submitBtn.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTF.snp.bottom).offset(50)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(44)
        }
    }
    
    /// 绑定模型
    private func bindModels(){
        BindingTarget(object: viewModel.dataModel, keyPath: #keyPath(LoginExampleModel.username)) <~ usernameTF.reactive.continuousTextValues
        BindingTarget(object: viewModel.dataModel, keyPath: #keyPath(LoginExampleModel.password)) <~ passwordTF.reactive.continuousTextValues
        submitBtn.reactive.pressed = CocoaAction<UIButton>(viewModel.logAction)
    }
    
    /// 展示消息
    private func consoleMessages(){
        viewModel.usernameProperty.signal.observeValues { value in
            print("usernameProperty+\(String(describing: value))")
        }
        viewModel.passwordProperty.signal.observeValues { (value) in
            print("passwordProperty+\(String(describing: value))")
        }
        viewModel.logAction.values.observeValues { (value) in
            print("logAction+\(value)")
        }
    }
}
