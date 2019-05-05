//
//  MRReactiveCocoaVC.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/5/5.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

/// Reactive cocoa view controller
class MRReactiveCocoaVC: MRBaseViewController {

    /// view Model
    private let viewModel = MRReactiveCocoaVM()

    /// 列表 视图
    lazy var tableview: UITableView = {
        let view = UITableView()
        view.tableFooterView = UIView()
        view.delegate = self
        view.dataSource = self.viewModel
        view.register(MRReactiveCocoaTCell.self, forCellReuseIdentifier: "MRReactiveCocoaTCell")
        self.view.addSubview(view)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func initialize() {
        self.title = "ReactiveCocoa"
    }
    
    override func bindingModel() {
        
    }
    
    override func deploySubviews() {
        tableview.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

// MARK: - UITableViewDelegate
extension MRReactiveCocoaVC: UITableViewDelegate{
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //"KVO","Notification","delegation","block","target-action"
        let title = self.viewModel.datas[indexPath.row]
        switch title {
        case "KVO":
            let kvovc = MRRACKVOVC()
            kvovc.title = "代替"+title
            self.navigationController?.pushViewController(kvovc, animated: true)
        case "Notification":
            print(title)
        case "delegation":
            print(title)
        case "block":
            print(title)
        case "target-action":
            print(title)
        default:
            break
        }
    }
    
}
