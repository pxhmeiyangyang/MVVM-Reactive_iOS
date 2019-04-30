//
//  LoginVC.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/19.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

import ReactiveCocoa
import ReactiveSwift


/// 登录界面
class LoginVC: UIViewController {
    
    private let viewModel = LoginVM()
    
    private let userNameTF = UITextField()
    private let passwordTF = UITextField()
    private let submitBTN = UIButton(type: UIButton.ButtonType.system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录页面"
        // Do any additional setup after loading the view.
        initialSubviews()
        bindModels()
        consoleMessages()
    }
    
    /// 初始化所有的子view
    private func initialSubviews(){
        self.view.addSubview(userNameTF)
        userNameTF.placeholder = "请输入账号"
        userNameTF.borderStyle = .roundedRect
        userNameTF.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(44)
        }
        
        self.view.addSubview(passwordTF)
        passwordTF.placeholder = "请输入密码"
        passwordTF.borderStyle = .roundedRect
        passwordTF.snp.makeConstraints { (make) in
            make.top.equalTo(userNameTF.snp.bottom).offset(50)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(44)
        }
        
        self.view.addSubview(submitBTN)
        submitBTN.setTitle("提交", for: UIControl.State.normal)
        submitBTN.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTF.snp.bottom).offset(50)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(44)
        }
    }
    
    
    /// 绑定模型
    private func bindModels(){
        //账号控件显示内容跟数据模型保持一致
        userNameTF.text = viewModel.userNameProperty.value
        viewModel.userNameProperty <~ userNameTF.reactive.continuousTextValues
        //密码控件显示内容跟数据模型保持一致
        passwordTF.text = viewModel.passwordProperty.value
        viewModel.passwordProperty <~ passwordTF.reactive.continuousTextValues
        //使用登录事件管理按钮状态
        submitBTN.reactive.pressed = CocoaAction(viewModel.loginAction)
    }
    
    /// 监控所有消息
    private func consoleMessages(){
        viewModel.loginAction.completed.observeValues {
            print("viewModel.loginAction: execution producer has completed")
        }
    }
}
