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
    private let submitButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSubviews()
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
    
}
