//
//  DNMineViewController.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/25.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

private let cellIdentifier = "cellID"

class DNMineViewController: DNBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(DNMineCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private lazy var tableView: UITableView = {
        let tableV = UITableView(frame: self.view.frame, style: .grouped)
        tableV.sectionHeaderHeight = 10
        tableV.sectionFooterHeight = 10
        tableV.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 20))
        
        tableV.delegate = self
        tableV.dataSource = self
        
        self.view.addSubview(tableV)
        
        return tableV
    }()
    
    lazy var dataArray: Array<Array<Dictionary<String, String>>> = {
        let dataArr = [
            [
                ["image" : "tx", "title" : "小熊老师"]
            ],
            [
                ["image" : "MoreMyAlbum", "title" : "相册"],
                ["image" : "MoreMyFavorites", "title" : "收藏"],
                ["image" : "MoreMyBankCard", "title" : "钱包"],
                ["image" : "MyCardPackageIcon", "title" : "卡包"]
            ],
            [
                ["image" : "MoreExpressionShops", "title" : "表情"]
            ],
            [
                ["image" : "MoreSetting", "title" : "设置"]
            ]
            
        ]
        return dataArr
    }()

}

extension DNMineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension DNMineViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray[section].count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DNMineCell
        
        cell.cellModel = self.dataArray[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section ==  0 ? 80.0 : 44.0
    }

}
