//
//  FillCustomerCell.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/4/27.
//  Copyright © 2017年 CrawfishBanking. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/27  下午1:07
//  GiantForJade:  Efforts to do my best
//  Real developers ship.


import UIKit
import DropDown

@objc protocol FillCustomerCellDelagete {
    
    @objc optional func inputString(_ str:String?,currentType: String?)
    
    @objc optional func rowInfo(_ row:String?,str:String?)
        
}

class FillCustomerCell: UITableViewCell ,UITextFieldDelegate{

    @IBOutlet weak var nameLb: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var currentModel: FillCustomerModel?
    var currentInfoModel:RequstPersonInfoModel?
    var currentRow:Int?
    weak var delegate: FillCustomerCellDelagete?
//    let dropDown2 = DropDown()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameTextField.delegate = self
    }

    func reloadUI(_ model: FillCustomerModel,isFillIn:Bool) {
        currentModel = model
        nameLb.text = model.nameStr
        
        if isFillIn {
            nameTextField.text = model.placeHodlerStr
        }
        
        if nameLb.text == "核定融资额度" {
            nameTextField.isEnabled = false
        }
    }

    func reloadRequestUI(_ model: RequstPersonInfoModel,row: Int) {
        
        currentInfoModel = model
        currentRow = row
        nameLb.text = model.nameStr
        nameLb.font = UIFont.systemFont(ofSize: 13)
        nameLb.adjustsFontSizeToFitWidth = true
        nameTextField.font = UIFont.systemFont(ofSize: 14)
        nameTextField.text = model.placeHodlerStr
        nameTextField.isEnabled = model.isEnable!
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        if currentModel != nil {
            
            delegate?.inputString!(textField.text, currentType: currentModel?.namefield)

        }
        
        if currentInfoModel != nil {
            
            delegate?.inputString!(textField.text, currentType: currentInfoModel?.namefield)
            delegate?.rowInfo!(String(describing: currentRow!),str: textField.text)
            
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


