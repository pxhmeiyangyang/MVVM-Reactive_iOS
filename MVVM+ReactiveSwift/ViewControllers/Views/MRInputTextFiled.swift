//
//  MRInputTextFiled.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/22.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

/// 输入框视图
class MRInputTextFiled: UIView {
    
    enum InputType {
        case account
        case password
        case repassword
    }
    
    private var type: InputType = .account
    
    lazy var iconIV: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: type == .account ? "icon_accout" : "icon_password")
        addSubview(imageView)
        return imageView
    }()

    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.init(fontName: SystemFontName.Regular, size: 14)
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.attributedPlaceholder = NSAttributedString.init(string: type == .account ? "请输入您的手机号" : "请输入您的登录密码", attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(rgb: 0xBCBCBC)])
        addSubview(textField)
        return textField
    }()
    
    lazy var hLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(rgb: 0x797979)
        addSubview(view)
        return view
    }()
    
    lazy var eyesBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage.init(named: "icon-Display password"), for: .selected)
        button.setBackgroundImage(UIImage.init(named: "icon-openeye"), for: .normal)
        addSubview(button)
        return button
    }()
    
    
    convenience init(inputType: InputType) {
        self.init()
        self.type = inputType
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch type {
        case .account:
            layoutAccountView()
        case .password:
            layoutPasswordView()
        case .repassword:
            layoutPasswordView()
        }
    }
    
    /// 布局账号界面
    private func layoutAccountView(){
        iconIV.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(self)
            make.width.height.equalTo(24)
        }
        
        inputTextField.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV.snp.right).offset(15)
            make.centerY.equalTo(self)
            make.right.equalTo(-14)
        }
        
        hLineView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.left.right.bottom.equalTo(0)
        }
    }
    
    /// 布局输入密码页面
    private func layoutPasswordView(){
        iconIV.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(self)
            make.width.height.equalTo(24)
        }
        
        eyesBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-8)
            make.centerY.equalTo(self)
            make.width.height.equalTo(24)
        }
        
        inputTextField.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV.snp.right).offset(15)
            make.centerY.equalTo(self)
            make.right.equalTo(-14)
        }
        
        hLineView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.left.right.bottom.equalTo(0)
        }
    }
}
