//
//  MRReactiveCocoaVC.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/5/5.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

/// Reactive cocoa view controller
class MRReactiveCocoaVC: MRBaseViewController {

    /// view Model
    private let viewModel = MRReactiveCocoaVM()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func initialize() {
        self.title = "ReactiveCocoa"
    }
    
    override func bindingModel() {
        self.KVO()
    }
    
    override func deploySubviews() {
        
    }
    
    private func KVO(){
        let temp = MRTempObject()
        let test = DynamicProperty<String?>(object: temp,keyPath: "name")
        test.producer.startWithValues { (value) in
            print("===========value: \(value ?? "")")
        }
        let nameProperty = DynamicProperty<String?>(object: temp, keyPath: #keyPath(MRTempObject.name))
        nameProperty.producer.startWithValues { (name) in
            print("===========name: \(name ?? "")")
        }
        temp.name = "2"
//        let temp = MRTempObject()
//        temp.name = "1"
//        temp = temp
        
        
        var tempObject = TempObject()
        let property = DynamicProperty<String?>(object: tempObject, keyPath: "property")
        property.producer.startWithValues { (value) in
            print("===========value: \(value ?? "")")
        }
        
        let property2 = DynamicProperty<String?>(object: tempObject, keyPath: #keyPath(TempObject.property))
        property2.producer.startWithValues { (value) in
            print("===========value: \(value ?? "")")
        }
        
        tempObject.property = "3"
        let test2 = TempObject()
        test2.property = "4"
        tempObject = test2
    }
    
}

