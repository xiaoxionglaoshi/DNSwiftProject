//
//  DNFoundViewController.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/25.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

private let cellIdentifier = "cellID"

class DNFoundViewController: DNBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(DNFoundCell.self, forCellReuseIdentifier: cellIdentifier)
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
                ["image" : "AlbumReflashIcon", "title" : "朋友圈"]
            ],
            [
                ["image" : "ff_IconQRCode", "title" : "扫一扫"],
                ["image" : "ff_IconShake", "title" : "摇一摇"]
            ],
            [
                ["image" : "ff_IconLocationService", "title" : "附近的人"],
                ["image" : "ff_IconBottle", "title" : "漂流瓶"]
            ],
            [
                ["image" : "CreditCard_ShoppingBag", "title" : "购物"],
                ["image" : "MoreGame", "title" : "游戏"]
            ]
            
        ]
        return dataArr
    }()
}

extension DNFoundViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 3 && indexPath.row == 0 {
            let wkWebVC = DNWKWebViewController()
            wkWebVC.urlString = "http://www.jd.com";
            self.navigationController?.pushViewController(wkWebVC, animated: true)
        }
    }
}

extension DNFoundViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray[section].count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DNFoundCell
        cell.cellModel = self.dataArray[indexPath.section][indexPath.row]
        return cell
    }
}
