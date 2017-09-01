//
//  GYPageContainerView.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/5/4.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/5/4  下午2:46
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

@objc protocol GYPageContainerViewDelegate {
    
    func  pageContainerView(_ progress:CGFloat,before: NSInteger,current: NSInteger)
    
}

class GYPageContainerView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource{

    weak var delegate: GYPageContainerViewDelegate?
    
    private var childVcArr:[UIViewController] = []
    private var parentVc: UIViewController = UIViewController()
    private var startOffsetX: CGFloat = 0
    private var currentOffsetX: CGFloat = 0
    private var progress: CGFloat = 0
    private var beforTitleIndex:NSInteger = 0
    private var currentTitleIndex: NSInteger = 0
    
    
    init(_ frame: CGRect,childVcs: [UIViewController],parentViewController: UIViewController) {
        super.init(frame: frame)
        childVcArr = childVcs
        parentVc = parentViewController
        
        setUI()
        
    }
    
    fileprivate func setUI() {
        
        for vc: UIViewController in childVcArr {
            parentVc.addChildViewController(vc)
        }
        
        addSubview(collectionView)
        collectionView.frame = self.bounds
        
    }
    
    func setPageContentViewChange(_ currentIndex: NSInteger){
        
        let offsetX = CGFloat(currentIndex) * collectionView.gy_width
                
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        
    }
    
    
    //MARK: - Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GYCellID", for: indexPath)
        
        let vc = childVcArr[indexPath.item] 
        vc.view.frame = self.bounds
        cell.contentView.addSubview(vc.view)
        
        return cell
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        startOffsetX = scrollView.contentOffset.x
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let scrollW = scrollView.gy_width
        
        currentOffsetX = scrollView.contentOffset.x
        if startOffsetX < currentOffsetX { //左滑
            
            progress = currentOffsetX / scrollW - floor(currentOffsetX / scrollW)
            beforTitleIndex = NSInteger(currentOffsetX / scrollW)
            currentTitleIndex = beforTitleIndex + 1
            
            if currentTitleIndex >= childVcArr.count {
                currentTitleIndex = childVcArr.count - 1
            }
            
            if currentOffsetX - startOffsetX == scrollW {
                progress = 1.0
                currentTitleIndex = beforTitleIndex
            }
            
        } else {// 右滑
            
            progress = 1 - (currentOffsetX / scrollW - floor(currentOffsetX / scrollW))
            currentTitleIndex = NSInteger(currentOffsetX / scrollW)
            beforTitleIndex = currentTitleIndex + 1
            
            if beforTitleIndex >= childVcArr.count {
                beforTitleIndex = childVcArr.count - 1
            }
            
        }
        
        delegate?.pageContainerView(progress, before: beforTitleIndex, current: currentTitleIndex)
        
        
    }
    
    private lazy var collectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.bounces = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "GYCellID")
        
        
        return collectionView
        
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

