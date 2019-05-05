//
//  MRRACKVOVC.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/5/5.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
/// RAC KVO view model
class MRRACKVOVC: MRBaseViewController {

    /// view model
    private let viewModel = MRRACKVOVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func initialize() {
    }
    
    override func bindingModel() {
        let test = DynamicProperty<String?>(object: self.viewModel.temp,keyPath: "name")
        test.producer.startWithValues { (value) in
            print("===========value: \(value ?? "")")
        }
        let nameProperty = DynamicProperty<String?>(object: self.viewModel.temp, keyPath: #keyPath(MRTempObject.name))
        nameProperty.producer.startWithValues { (name) in
            print("===========name: \(name ?? "")")
        }
        self.viewModel.temp.name = "2"
        let temp = MRTempObject()
        temp.name = "1"
        self.viewModel.temp = temp
        
        
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
    
    override func deploySubviews() {
        
    }

}
