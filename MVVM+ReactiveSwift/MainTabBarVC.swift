//
//  MainTabBarVC.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/19.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

/// 工程核心界面MainTabbarViewController
class MainTabBarVC: UITabBarController {

    /// 单例对象
    static let sharedInstance = MainTabBarVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViewControllers()
    }
    
    /// 添加工程子VC
    private func addSubViewControllers(){
        let emailVC = EmailVC()
        emailVC.title = "邮箱校验"
        emailVC.tabBarItem.image = UIImage.init(named: "首页iconaudition1")?.withRenderingMode(.alwaysOriginal)
        emailVC.tabBarItem.selectedImage = UIImage.init(named: "首页iconaudition2")?.withRenderingMode(.alwaysOriginal)
        
        let loginVC = LoginVC()
        loginVC.title = "登录页面"
        loginVC.tabBarItem.image = UIImage.init(named: "首页iconchat2")?.withRenderingMode(.alwaysOriginal)
        loginVC.tabBarItem.selectedImage = UIImage.init(named: "首页iconchat3")?.withRenderingMode(.alwaysOriginal)
        
        let loginExampleVC = LoginExampleVC()
        loginExampleVC.title = "登录2页面"
        loginExampleVC.tabBarItem.image = UIImage.init(named: "首页iconchat2")?.withRenderingMode(.alwaysOriginal)
        loginExampleVC.tabBarItem.selectedImage = UIImage.init(named: "首页iconchat3")?.withRenderingMode(.alwaysOriginal)
        
        self.viewControllers = [loginVC,loginExampleVC,emailVC]
        self.selectedIndex = 0
    }
    
}
