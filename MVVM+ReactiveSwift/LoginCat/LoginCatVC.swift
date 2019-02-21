//
//  LoginCatVC.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/21.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

import Result
import ReactiveCocoa
import ReactiveSwift

class LoginCatVC: UIViewController {

    private let usernameTF = UITextField()
    private let passwordTF = UITextField()
    private let submitBTN = UIButton(type: UIButton.ButtonType.system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSubviews()
    }

    /// 初始化加载子页面
    private func initialSubviews(){
        self.view.addSubview(usernameTF)
        usernameTF.borderStyle = .roundedRect
        usernameTF.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(40)
        }
        
        self.view.addSubview(passwordTF)
        passwordTF.borderStyle = .roundedRect
        passwordTF.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTF.snp.bottom).offset(50)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(40)
        }
        
        self.view.addSubview(submitBTN)
        
        submitBTN.setTitle("submit", for: .normal)
        submitBTN.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTF.snp.bottom).offset(50)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(40)
        }
    }
    
    
}
