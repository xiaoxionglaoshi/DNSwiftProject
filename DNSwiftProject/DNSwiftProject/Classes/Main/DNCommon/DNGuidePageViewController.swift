//
//  DNGuidePageViewController.swift
//  DNSwiftProject
//
//  Created by mainone on 16/11/25.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

// 引导图数量
private let kGuidePageCount = 4

private let reuseIdentifier = "guidePageCell"

class DNGuidePageViewController: UICollectionViewController {
    
    //定义布局对象
    private var layout: UICollectionViewLayout = DNGuidePageLayout()
    
    init() {
        super.init(collectionViewLayout: layout)
    }
    
    deinit {
        print("guide page view deinitial")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.collectionView!.register(DNGuidePageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kGuidePageCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DNGuidePageCell
        cell.imageIndex = indexPath.item
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let path = collectionView.indexPathsForVisibleItems.last!
        let cell = collectionView.cellForItem(at: path) as! DNGuidePageCell
        
        // 最后一页动画显示进入按钮
        if path.item == (kGuidePageCount - 1) {
            cell.startBtnAnimation()
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
}

// MARK: DNGuidePageLayout
private class DNGuidePageLayout: UICollectionViewFlowLayout {
    // 准备布局
    fileprivate override func prepare() {
        // 设置layout布局
        itemSize = UIScreen.main.bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        
        // 设置collectionView属性
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false
        collectionView?.isPagingEnabled = true
    }
}

// MARK: DNGuidePageCell
private class DNGuidePageCell: UICollectionViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
    }
    
    private lazy var iconView = UIImageView()
    private lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "btn_begin"), for: .normal)
        btn.addTarget(self, action: #selector(startButtonClick), for: .touchUpInside)
        return btn
    }()
    
    @objc private func startButtonClick() {
        UIApplication.shared.keyWindow?.rootViewController = DNTabBarViewController()
    }
    
    // 按钮显示
    func startBtnAnimation() {
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: .layoutSubviews, animations: {
            self.startButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (_) in
            self.startButton.isUserInteractionEnabled = true
        }
    }
    
    func hiddenBtnAnimation() {
        self.startButton.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        self.startButton.isUserInteractionEnabled = false
    }
    
    // 设置图片名
    var imageIndex: Int? {
        didSet {
            iconView.image = UIImage(named: "walkthrough_\(imageIndex! + 1)")
            self.hiddenBtnAnimation()
        }
    }
    
    // 创建UI
    func setUpUI() {
        self.backgroundColor = UIColor.white
        // 添加视图控件
        contentView.addSubview(iconView)
        contentView.addSubview(startButton)
        
        iconView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        startButton.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
        startButton.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height - 60)
    }
}
