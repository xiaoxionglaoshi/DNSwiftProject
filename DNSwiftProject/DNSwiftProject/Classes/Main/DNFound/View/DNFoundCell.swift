//
//  DNFoundCell.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/14.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

class DNFoundCell: UITableViewCell {
    private lazy var cellImageView =  UIImageView()
    private lazy var cellTitleLabel = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        
        self.setUIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var cellModel: Dictionary<String, String>? {
        didSet {
            cellImageView.image = UIImage(named: (cellModel?["image"])!)
            cellTitleLabel.text = cellModel?["title"]
            
            cellImageView.frame = CGRect(x: 15, y: 10, width: contentView.frame.size.height - 20, height: contentView.frame.size.height - 20)
            cellTitleLabel.frame = CGRect(x: contentView.frame.size.height + 5, y: 0, width: contentView.frame.size.width - contentView.frame.size.height - 50, height: contentView.frame.size.height)
        }
    }
    
    private func setUIView() {
        contentView.addSubview(cellImageView)
        contentView.addSubview(cellTitleLabel)
    }

}
