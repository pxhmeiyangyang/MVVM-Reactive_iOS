//
//  BookListVC.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/21.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

import ReactiveCocoa
import ReactiveSwift
/// book list view controller
class BookListVC: UIViewController {

    private let tableview = UITableView()
    
    private lazy var viewModel = {
        return BookListVM()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deploySubviews()
        initialBind()
    }

    /// 配置子页面
    private func deploySubviews(){
        self.view.addSubview(tableview)
        tableview.tableFooterView = UIView()
        tableview.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(0)
        }
    }
    
    /// 绑定模型
    private func initialBind(){
        tableview.delegate = viewModel
        tableview.dataSource = viewModel
        viewModel.bookAction.apply(()).startWithResult { result in
            switch result{
            case let .success(value):
                self.viewModel.models = value
                self.tableview.reloadData()
            default:
                break
            }
        }
    }

}
