//
//  DNCycleViewCell.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/23.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit
import SnapKit

class DNCycleViewCell: UICollectionViewCell {
    /// 文字标题间距
    private let KMargin = CGFloat(8)
    /// 轮播图片
    lazy var imageView = UIImageView()
    /// 轮播标题
    lazy var titleLab = UILabel()
    
    // 外接Model数据
    var cycleModel:  DNCycleModel? {
        didSet {
            if let imageStr = cycleModel?.imageString {
                imageView.kf.setImage(with: URL(string: imageStr), placeholder: UIImage(named: "placeHolder"))

            }
            titleLab.text = cycleModel?.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width:bounds.width , height: bounds.height))
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        
        let backView = UIView()
        backView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        addSubview(backView)
        
        titleLab = UILabel()
        titleLab.tag = 2
        titleLab.textColor = UIColor.white
        titleLab.textAlignment = .left
        titleLab.numberOfLines = 0
        titleLab.font = UIFont(name: "TimesNewRomanPS-ItalicMT", size: 13)
        backView.addSubview(titleLab)
        
        backView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-15)
            make.height.greaterThanOrEqualTo(20)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.edges.equalTo(backView).inset(UIEdgeInsetsMake(5, 5, 5, 5))
        }
    }
}
