//
//  MRLoginVC.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/22.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

import Result
import ReactiveCocoa
import ReactiveSwift

/// 登录页面
class MRLoginVC: MRBaseViewController {

    private let viewModel = MRLoginVM()
    
    lazy var userNameTF: MRInputTextFiled = {
        let textField = MRInputTextFiled.init(inputType: MRInputTextFiled.InputType.account)
        self.view.addSubview(textField)
        return textField
    }()
    
    lazy var passwordTF: MRInputTextFiled = {
        let textField = MRInputTextFiled.init(inputType: MRInputTextFiled.InputType.password)
        self.view.addSubview(textField)
        return textField
    }()
    
    lazy var loginBtn: UIButton = {
        let button = UIButton.init(customType: UIButton.MRCustomType.login)
        self.view.addSubview(button)
        return button
    }()
    
    lazy var registerBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("立即注册", for: UIControl.State.normal)
        button.setTitleColor(UIColor.darkGray, for: UIControl.State.highlighted)
        button.setTitleColor(UIColor.init(rgba: 0x4B7FEBFF), for: .normal)
        button.titleLabel?.font = UIFont.init(fontName: SystemFontName.Regular, size: 15)
        self.view.addSubview(button)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        // Do any additional setup after loading the view.
    }
    
    override func layoutUI() {
        loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(35)
            make.right.equalTo(-35)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
        }
        
        passwordTF.snp.makeConstraints { (make) in
            make.left.right.equalTo(loginBtn)
            make.height.equalTo(40)
            make.bottom.equalTo(loginBtn.snp.top).offset(-38)
        }
        
        userNameTF.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(loginBtn)
            make.bottom.equalTo(passwordTF.snp.top).offset(-25)
        }
        
        registerBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-45)
            make.top.equalTo(loginBtn.snp.bottom).offset(15)
        }
    }
    
    override func bindModels() {
        BindingTarget(object: viewModel.loginModel, keyPath: #keyPath(MRLoginModel.username)) <~ userNameTF.inputTextField.reactive.continuousTextValues
        
        BindingTarget(object: viewModel.loginModel, keyPath: #keyPath(MRLoginModel.password)) <~ passwordTF.inputTextField.reactive.continuousTextValues
        
        loginBtn.reactive.isEnabled <~ viewModel.loginEnableProducer
        
        passwordTF.inputTextField.reactive.isSecureTextEntry <~ DynamicProperty<Bool>.init(object: passwordTF.eyesBtn, keyPath: #keyPath(UIButton.isSelected))
        
        passwordTF.eyesBtn.reactive.controlEvents(.touchUpInside).observeValues { $0.isSelected = !$0.isSelected }
        //注册按钮点击事件
        registerBtn.reactive.controlEvents(.touchUpInside).observeValues { (sender) in
            print("注册按钮点击事件")
        }
        //点击登录按钮触发登录事件
        loginBtn.reactive.controlEvents(.touchUpInside).observeValues { [weak self](sender) in
            self?.viewModel.loginActionPtoducer.startWithResult({ (result) in
                switch result{
                case .success(_):
                    print("登录成功")
                    self?.dismiss(animated: true, completion: nil)
                case .failure(_):
                    print("登录失败")
                }
            })
        }
    }
    
}
