//
//  DNCycleView.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/23.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit
import Kingfisher

protocol DNCycleViewDelegate: NSObjectProtocol {
    func cycleViewDidSelected(cycleView: DNCycleView, selectedIndex: Int)
}

private let CycleViewCell = "DNCycleViewCell"

class DNCycleView: UIView {
    
    open var isAutoScroll: Bool? // 是否允许滚动,默认true

    weak var delegate: DNCycleViewDelegate?
    lazy var collectionView = UICollectionView()
    var dataArr: [DNCycleModel]?
    
    fileprivate lazy var pageControl = UIPageControl()
    fileprivate var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isAutoScroll = true
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        collectionView.delegate = nil
        collectionView.dataSource = nil
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview == nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    fileprivate func setupUI(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        collectionView.register(DNCycleViewCell.self, forCellWithReuseIdentifier: CycleViewCell)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: IndexPath.init(row: 0, section: 5000), at: .right, animated: false)
            self.addPageControl()
        }
    }
    
    func addPageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: bounds.height - 20, width: bounds.width, height: 20))
        guard let dataArr = dataArr else {
            return
        }
        pageControl.numberOfPages = dataArr.count
        pageControl.isUserInteractionEnabled = false
        
        let pageControlSelectedImage = UIImage(named: "mn_pageControl_selected")
        let pageControlImage = UIImage(named: "mn_pageControl")
        pageControl.setValue(pageControlSelectedImage, forKey: "_currentPageImage")
        pageControl.setValue(pageControlImage, forKey: "_pageImage")
        addSubview(pageControl)
        guard isAutoScroll! else {
            return
        }
        beginScroll()
    }
    
    func beginScroll() {
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(scrollAction), userInfo: nil, repeats: true)
        guard let timer = timer else {
            return
        }
        RunLoop.main.add(timer, forMode: .commonModes)
    }
    
    @objc private func scrollAction() {
        guard let cell = collectionView.visibleCells.first as? DNCycleViewCell,
            let currentIndexPath = collectionView.indexPath(for: cell) else {
                return
        }
        var section = currentIndexPath.section
        var item = currentIndexPath.item + 1
        guard let dataArr = dataArr else {
            return
        }
        
        if item == dataArr.count {
            section += 1
            item = 0
        }
        collectionView.scrollToItem(at: IndexPath.init(row: item, section: section), at: .right, animated: true)
        pageControl.currentPage = item
    }

}

// MARK: - scrollViewDelegate
extension DNCycleView {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        guard let dataArr = dataArr else {
            return
        }
        let page = NSInteger((scrollView.contentOffset.x / bounds.width)) % dataArr.count
        pageControl.currentPage = page
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let dataArr = dataArr else {
            return
        }
        
        let page = NSInteger((scrollView.contentOffset.x / bounds.width)) % dataArr.count
        pageControl.currentPage = page
        beginScroll()
    }
}


// MARK: - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension DNCycleView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataArr = dataArr else {
            return 0
        }
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CycleViewCell, for: indexPath) as! DNCycleViewCell
        guard let dataArr = dataArr else {
            return UICollectionViewCell()
        }
        let cycleModel = dataArr[indexPath.row]
        cell.cycleModel = cycleModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cycleViewDidSelected(cycleView: self, selectedIndex: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.width, height: bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

