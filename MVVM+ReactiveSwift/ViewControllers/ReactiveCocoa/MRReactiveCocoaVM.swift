//
//  MRReactiveCocoaVM.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/5/5.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

/// Reactive cocoa viewModel
class MRReactiveCocoaVM: MRBaseViewModel {
    
    /// 数据源 统一消息传递机制  KVO、Notification、delegation、block 以及 target-action 方式
    var datas = ["KVO","Notification","delegation","block","target-action"]
    
    override func initialize() {
        
    }
    
    override func bindingModel() {
        
    }
    
    override func deploySubviews() {
        
    }
}

// MARK: - UITableViewDataSource
extension MRReactiveCocoaVM: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MRReactiveCocoaTCell", for: indexPath) as? MRReactiveCocoaTCell else { return UITableViewCell() }
        cell.textLabel?.text = self.datas[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
        
}
