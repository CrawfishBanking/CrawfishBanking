//
//  RNGuideViewController.swift
//  HoyoServicer
//
//  Created by 婉卿容若 on 16/5/10.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit

typealias GuideCellClosure = () -> Void

class GuideCell: UICollectionViewCell {
    
    fileprivate let newImageView = UIImageView(frame: (appDelegate.window?.frame)!)
    fileprivate let nextButton = UIButton(frame: CGRect(x: (Screen_Width - 250)/2, y: Screen_Height - 70, width: 250, height: 72.5))
    
    internal var cellClosure: GuideCellClosure?
    
    var newImage: UIImage? {
        didSet {
            newImageView.image = newImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        newImageView.contentMode = UIViewContentMode.scaleAspectFill
        contentView.addSubview(newImageView)
        
        
        //修改按钮位置
        nextButton.setBackgroundImage(UIImage(named: "icon_next"), for: UIControlState())
        nextButton.setTitleColor(UIColor.white, for: UIControlState.normal)
//        nextButton.setTitle("立即体验", for: UIControlState.normal)
        nextButton.titleLabel?.textAlignment = .center
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        nextButton.addTarget(self, action: #selector(GuideCell.nextButtonClick), for: UIControlEvents.touchUpInside)
        nextButton.isHidden = true
        contentView.addSubview(nextButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNextButtonHidden(_ hidden: Bool) {
        nextButton.isHidden = hidden
    }
    
    func nextButtonClick() {
       // NSNotificationCenter.defaultCenter().postNotificationName(GuideViewControllerDidFinish, object: nil)
        
        if cellClosure != nil  {
            cellClosure!()
        }
    }
}
