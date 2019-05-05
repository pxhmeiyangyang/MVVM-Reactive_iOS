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
    
    /// 是否登录
    var isLogin: Bool = false
    
    /// 单例对象
    static let sharedInstance = MainTabBarVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.addSubViewControllers()
        }
        if !isLogin {
            presentToLogin()
        }
    }
    
    /// 添加工程子VC
    private func addSubViewControllers(){
        let bookListVC = BookListVC()
        bookListVC.title = "书本列表"
        bookListVC.tabBarItem.image = UIImage.init(named: "首页iconaudition1")?.withRenderingMode(.alwaysOriginal)
        bookListVC.tabBarItem.selectedImage = UIImage.init(named: "首页iconaudition2")?.withRenderingMode(.alwaysOriginal)
        
        let emailVC = EmailVC()
        emailVC.title = "邮箱校验"
        emailVC.tabBarItem.image = UIImage.init(named: "首页iconaudition1")?.withRenderingMode(.alwaysOriginal)
        emailVC.tabBarItem.selectedImage = UIImage.init(named: "首页iconaudition2")?.withRenderingMode(.alwaysOriginal)
        
        let reactiveCocoaVC = UINavigationController.init(rootViewController: MRReactiveCocoaVC())
        reactiveCocoaVC.tabBarItem.title = "ReactiveCocoa"
        reactiveCocoaVC.tabBarItem.image = UIImage.init(named: "首页iconchat2")?.withRenderingMode(.alwaysOriginal)
        reactiveCocoaVC.tabBarItem.selectedImage = UIImage.init(named: "首页iconchat3")?.withRenderingMode(.alwaysOriginal)
        
        let loginExampleVC = LoginExampleVC()
        loginExampleVC.title = "登录2页面"
        loginExampleVC.tabBarItem.image = UIImage.init(named: "首页iconchat2")?.withRenderingMode(.alwaysOriginal)
        loginExampleVC.tabBarItem.selectedImage = UIImage.init(named: "首页iconchat3")?.withRenderingMode(.alwaysOriginal)
        
        self.viewControllers = [bookListVC,reactiveCocoaVC,loginExampleVC,emailVC]
        self.selectedIndex = 0
    }
    
    
    /// 跳转到登录界面
    private func presentToLogin(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.present(UINavigationController.init(rootViewController: MRLoginVC()), animated: false, completion: nil)
        }
    }
}
