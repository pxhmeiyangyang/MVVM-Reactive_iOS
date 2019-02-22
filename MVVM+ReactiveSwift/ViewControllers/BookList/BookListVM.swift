//
//  BookListVM.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/21.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit
import Result
import ReactiveCocoa
import ReactiveSwift
/// book list view model
class BookListVM: NSObject {
    var models = [BookListModel]()
    var bookAction: Action<(),[BookListModel],AnyError>!
    private let data = [["test1":"1"],["test2":"3"],["test3":"3"],["test4":"4"],["test5":"5"],["test6":"6"],["test7":"7"],] //模拟网络请求数据
    override init() {
        super.init()
        initialBind()
    }
    
    private func initialBind(){
        bookAction = Action<(),[BookListModel],AnyError>{  (_) -> SignalProducer<[BookListModel], AnyError> in
            SignalProducer<[[String : String]], AnyError>({observer, disposable in
                //模拟网络请求 将请求数据通过信号发送出去
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                    observer.send(value: self.data)
                    observer.sendCompleted()
                })
            }).map({ (dics) -> [BookListModel] in
                var books = [BookListModel]()
                for dic in dics{
                    let book = BookListModel()
                    book.title = dic.keys.first
                    book.subTitle = dic.values.first
                    books.append(book)
                }
                return books
            })
        }
    }
}

extension BookListVM: UITableViewDelegate,UITableViewDataSource{
    //UITabelviewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    //UITableviewDatasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        let book = models[indexPath.row]
        cell?.textLabel?.text = book.title
        cell?.detailTextLabel?.text = book.subTitle
        return cell!
    }
}
