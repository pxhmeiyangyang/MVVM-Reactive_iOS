# MVVM+ReactiveCocoa+Swift4.0 iOS项目学习实践

## v1.0

>- 1、创建一个新的swift iOS App工程
>- 2、commit id: f71ed62e265e2d0ef6922dfe94a5f446ce43dff6

### v1.1 工程简介

>一、此项目为MVVM+Reactive+swift4.0的学习项目
>
>[MVVM介绍](https://baike.baidu.com/item/MVVM/96310?fr=aladdin)
>
![avatar](https://github.com/pxhmeiyangyang/MVVM-Reactive_iOS/blob/master/MarkDown/660px-MVVMPattern.png)
>最近在Review项目的代码发现一个严重的问题，成吨的代码和复杂的结构看的人都傻了，于是决定学习一下MVVM+RAC。
>
>二、工程实现进度预期：
>
>1、登录界面、登录逻辑（已实现）
>
>2、ReactiveCocoa常用API使用示例（待实现）
>
>3、常用UI控件的使用示例（待实现）
>
>4、实现一个基本完整的APP（待实现）

###v1.2 登录界面实现
实现效果如下：
![conv_ops](https://github.com/pxhmeiyangyang/MVVM-Reactive_iOS/blob/master/MarkDown/myyView.gif)
1、登录数据模型

声明为@objcMembers  OC数据类型，方便后续绑定模型

```
import UIKit

/// 登录模型
@objcMembers
class MRLoginModel: NSObject {
    var username: String?
    var password: String?
}
```

2、创建base viewModel和base viewController

在base viewModel和base viewController中创建并加载共用函数

base viewModel代码如下

```
import UIKit

/// MVVM+ReactiveSwift
class MRBaseViewModel: NSObject {
    
    override init() {
        super.init()
        initialBind()
    }
    
    func initialBind(){}
}
```

base viewController代码如下

```
import UIKit

class MRBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        bindModels()
    }
    
    /// 布局UI界面
    func layoutUI(){}
    
    /// 绑定模型
    func bindModels(){}

}
```

3、实现登录界面的viewModel

```
import UIKit
import Result
import ReactiveCocoa
import ReactiveSwift

/// 登录页面的viewModel
class MRLoginVM: MRBaseViewModel {

    let loginModel = MRLoginModel()
    var loginEnableProducer : SignalProducer<Bool,NoError>!
    var loginActionPtoducer : SignalProducer<Bool,NoError>!
    
    override init() {
        super.init()
    }
    
    override func initialBind() {
        let usernameProperty = DynamicProperty<String?>.init(object: loginModel, keyPath: #keyPath(MRLoginModel.username))
        let passwordProperty = DynamicProperty<String?>.init(object: loginModel, keyPath: #keyPath(MRLoginModel.password))
        loginEnableProducer = SignalProducer.combineLatest(usernameProperty, passwordProperty).map({ (username,password) -> Bool in
            return username?.count ?? 0 >= 5 && password?.count ?? 0 >= 5
        })
        loginActionPtoducer = SignalProducer<Bool,NoError>.init({ [weak self] (observe,disposable) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                observe.send(value: true)
                observe.sendCompleted()
            })
        })
    }
    
}
```

4、实现登录界面的viewController

```
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
                case .failure(_):
                    print("登录失败")
                }
            })
        }
    }
    
}
```
5、[完整代码下载](https://github.com/pxhmeiyangyang/MVVM-Reactive_iOS)
/MVVM+ReactiveSwift/ViewControllers/Login&Register文件夹下为以上代码


