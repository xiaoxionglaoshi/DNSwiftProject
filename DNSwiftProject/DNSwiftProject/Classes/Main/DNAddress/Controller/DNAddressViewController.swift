//
//  DNAddressViewController.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/25.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

class DNAddressViewController: DNBaseViewController {
    
    lazy var tableView = UITableView()
    lazy var modelArr = [DNCycleModel]()
    var cycleView: DNCycleView?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        
        cycleView = DNCycleView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 250))
        cycleView?.delegate = self
        tableView.tableHeaderView = cycleView
        requestData()
    }
    
    func requestData() {
        let tempArr = [["title":"中国奥运军团三金回顾","imageString":"http://pic33.nipic.com/20130916/3420027_192919547000_2.jpg"],
                       ["title":"《封神传奇》进世界电影特效榜单？山寨的!","imageString":"https://github.com/codestergit/SweetAlert-iOS/blob/master/SweetAlertiOS.gif?raw=true"],
                       ["title":"奥运男子4x100自由泳接力 菲尔普斯,奥运男子4x100自由泳接力 菲尔普斯,奥运男子4x100自由泳接力 菲尔普斯,奥运男子4x100自由泳接力 菲尔普斯","imageString":"http://i1.hexunimg.cn/2014-08-15/167580248.jpg"],
                       ["title":"顶住丢金压力 孙杨晋级200自决赛","imageString":"http://pic6.huitu.com/res/20130116/84481_20130116142820494200_1.jpg"]];
        for dict in tempArr {
            let model = DNCycleModel(fromDict: dict)
            modelArr.append(model)
        }
        
        cycleView?.dataArr = modelArr
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DNAddressViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = "我排在第\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let userInfo = ["url" : "www.baidu.co"]
        LocalNotificationHelper.sharedInstance().scheduleNotificationWithKey(key: "baidu", title: "我是百度", message: "Lets take a break", seconds: 5, userInfo: userInfo as [NSObject : AnyObject]?)
    }
}

extension DNAddressViewController: DNCycleViewDelegate {
    func cycleViewDidSelected(cycleView: DNCycleView, selectedIndex: NSInteger) {
        print("打印了\(selectedIndex)")
    }
}
