//
//  MRLoginVC.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/22.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

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

        // Do any additional setup after loading the view.
    }
    
    override func layoutUI() {
        loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(35)
            make.right.equalTo(-35)
            make.center.equalToSuperview()
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
        
 
    }
    
}
