//
//  UIButton+MRCustom.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/22.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

extension UIButton{
    enum MRCustomType {
        case login
        case getVerificationCode
    }
    
    convenience init(customType: MRCustomType) {
        self.init(type: .custom)
        switch customType {
        case .login:
            self.setTitle("登录", for: UIControl.State.normal)
            self.setBackgroundImage(UIImage.init(named: "btn-Sign in-activate"), for: .normal)
            self.setBackgroundImage(UIImage.init(named: "btn-Sign in-Pressed"), for: .highlighted)
            self.setBackgroundImage(UIImage.init(named: "btn-Sign in-disabled"), for: .disabled)
            self.setTitleColor(UIColor.white, for: UIControl.State.normal)
            self.setTitleColor(UIColor.init(rgb: 0x666666), for: .disabled)
            self.titleEdgeInsets = UIEdgeInsets.init(top: -2, left: 0, bottom: 0, right: 0)
            self.titleLabel?.font = UIFont.init(fontName: .Regular)
            self.isEnabled = false
        case .getVerificationCode:
            self.setTitle("注册", for: UIControl.State.normal)
            self.setBackgroundImage(UIImage.init(named: "btn_next-nor"), for: .normal)
            self.setBackgroundImage(UIImage.init(named: "btn-next-pressed"), for: .normal)
            self.setBackgroundImage(UIImage.init(named: "btn-next-disabled"), for: .normal)
            self.setTitleColor(UIColor.white, for: UIControl.State.normal)
            self.titleEdgeInsets = UIEdgeInsets.init(top: -2, left: 0, bottom: 0, right: 0)
            self.titleLabel?.font = UIFont.init(fontName: .Regular)
            self.isEnabled = false
        }
    }
}
