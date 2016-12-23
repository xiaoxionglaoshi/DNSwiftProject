//
//  DNCycleViewCell.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/23.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

class DNCycleViewCell: UICollectionViewCell {
    /// 文字标题间距
    private let KMargin = CGFloat(8)
    /// 轮播图片
    lazy var imageView = UIImageView()
    /// 轮播标题
    lazy var titleLab = UILabel()
    
    var cycleModel: DNCycleModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width:bounds.width , height: bounds.height))
        addSubview(imageView)
        
        titleLab = UILabel(frame: CGRect(x: KMargin, y: bounds.height - 50, width: bounds.width - 2*KMargin, height: 30))
        titleLab.backgroundColor = UIColor.black
        titleLab.tag = 2
        titleLab.textColor = UIColor.white
        titleLab.textAlignment = .center
        titleLab.font = UIFont.systemFont(ofSize: 15)
        titleLab.alpha = 0.5
        addSubview(titleLab)
    }
}
