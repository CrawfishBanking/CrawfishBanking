//
//  GYPageTitleView.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/5/4.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/5/4  下午2:45
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

@objc protocol GYPageTitleViewDelegate {
    
    func pageCurrentTitle(_ index: NSInteger)
    
}

class GYPageTitleView: UIView {

    weak var delegate: GYPageTitleViewDelegate?
    
    private var currentIndex: NSInteger = 0
    
    private var titlesArr:[String] = []
    
    private var labelsArr: [UILabel] = []
    
    init(_ frame: CGRect,titles: [String]) {
        super.init(frame: frame)
        titlesArr = titles
        
        initUI()
    }
    
    func setTitleChange(_ progress: CGFloat, before: NSInteger,currentIndex: NSInteger) {

        let before = labelsArr[before]
        let current = labelsArr[currentIndex]
    
        let moveTotalX = current.x - before.x
        let titleMoveX = moveTotalX * progress
        scrollLine.x = before.x + titleMoveX
        if progress > 0.5 {
            
            before.textColor = UIColor.lightGray
            current.textColor = UIColor.init(85, g: 36, b: 251, a: 1.0)
        } else {
            
            before.textColor = UIColor.init(85, g: 36, b: 251, a: 1.0)
            current.textColor = UIColor.lightGray
        }

        self.currentIndex = currentIndex
        
    }
    
    fileprivate func initUI() {
        
        addSubview(scrollView)
        scrollView.frame = self.bounds
        
        addLb()
        
        addBootomLine()
        
    }
    
    fileprivate func addBootomLine() {
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        
        let lb = labelsArr[0]
        lb.textColor = UIColor.init(85, g: 36, b: 251, a: 1.0)
        let lineH:CGFloat = 0
        bottomLine.frame = CGRect(x: 0, y: self.gy_height - lineH - 3, width: Screen_Width, height: 3)
        scrollView.addSubview(bottomLine)
        
        scrollLine.frame = CGRect(x: lb.x, y: self.gy_height - lineH - 3, width: lb.gy_width, height: 3)
        scrollView.addSubview(scrollLine)
        
    }
    
    fileprivate func addLb() {
        
        let labelW = self.frame.width / CGFloat(titlesArr.count)
        let labelH = self.frame.height - 12
        
        let labellY = 0.0
        
        for i in 0..<titlesArr.count {
            
            let lb = UILabel()
            lb.text = titlesArr[i]
            lb.textAlignment = .center
            lb.font = UIFont.systemFont(ofSize: 15.0)
            lb.textColor = UIColor.lightGray
            lb.tag = i
            lb.frame = CGRect(x: labelW * CGFloat(i), y: CGFloat(labellY), width: labelW, height: labelH)
            scrollView.addSubview(lb)
            
            labelsArr.append(lb)
            
            lb.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(labTapClick(_:)))
            
            lb.addGestureRecognizer(tap)
        }
        
        
    }
    
    
    
    func labTapClick(_ tap:UITapGestureRecognizer) {
        
        let lb = tap.view as! UILabel
        
        guard lb.tag != currentIndex else {
            return
        }
        
        let beforeLb = labelsArr[currentIndex]
        lb.textColor = UIColor.init(85, g: 36, b: 251, a: 1.0)

        beforeLb.textColor = UIColor.lightGray
        currentIndex = lb.tag
        
        let scrolllineX = CGFloat(currentIndex) * scrollLine.frame.width
        
        UIView.animate(withDuration: 0.3) {  [weak self] in
            self?.scrollLine.x = scrolllineX
        }
        
        delegate?.pageCurrentTitle(currentIndex)
        
    }
    
    private lazy var scrollLine: UIView = {
       
        let line = UIView()
        line.backgroundColor = UIColor.init(85, g: 36, b: 251, a: 1.0)
        
        return line
        
    }()
    
    private lazy var scrollView: UIScrollView = {
        
        let sc = UIScrollView()
        sc.showsHorizontalScrollIndicator = false
        sc.scrollsToTop = false
        sc.bounces = false
        
        return sc
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
