//
//  PersonInfoRealm.swift
//  CrawfishBanking
//
//  Created by ZGY on 2017/6/12.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/6/12  下午3:52
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
import RealmSwift
import Realm

class RequestRealm: Object {
    
    dynamic var requestRealmID = ""
    
    
    
    dynamic var ApplyUserPhone = ""
    ///
    
    /// 社会信用代码
    ///
    
    
    dynamic var CeditNo = ""
    ///
    
    /// 组织机构代码证
    ///
    
    
    dynamic var OrganCode = ""
    ///
    
    /// 营业执照编号
    ///
    
    
    dynamic var LicenseNo = ""
    ///
    
    //期限
    dynamic var Term = ""
    //融资额度
    dynamic var Funding = ""
    /// 经营性质
    ///
    dynamic var BusinessNature = ""
    
    ///
    
    /// 经验场所
    ///
    
    
    dynamic var Premises = ""
    ///
    
    /// 邮编
    ///
    
    
    dynamic var ZipCode = ""
    ///
    
    /// 公司电话
    ///
    
    
    dynamic var CompanyPhone = ""
    ///
    
    /// 关联企业
    ///
    
    
    dynamic var Associate = ""
    
    dynamic var  AssociateCount = ""
    
    dynamic var isHaveAssociate = ""
    ///
    
    /// 身份证号码
    ///
    
    
    dynamic var IDNumber = ""
    ///
    
    /// 法人地址固定电话
    ///
    
    
    dynamic var Telephone = ""
    ///
    
    /// 联系地址
    ///
    
    
    dynamic var Address = ""
    ///
    
    /// 电邮
    ///
    
    
    dynamic var Email = ""
    ///
    
    /// 主营业务营业额
    ///
    
    
    dynamic var Quota = ""
    ///
    
    /// 主营业务实际经营年限
    ///
    
    
    dynamic var Experience = ""
    ///
    
    /// 主营业务
    ///
    
    
    dynamic var MojorBusiness = ""
    
    /// <summary>
    /// 年收入
    /// </summary>
    dynamic var YearIncome = ""
    ///
    
    /// 除主营业务外其它收入来源
    ///
    
    dynamic var OtherSources = ""
    
    /// 是否有 除主营业务外其它收入来源（0：无，1：有）
    dynamic var IsHasOther = ""
    /// <summary>
    /// 除主营业务外其它收入来源 年收入
    /// </summary>
    dynamic var OtherIncome = ""
    /// <summary>
    /// 除主营业务外其它收入来源 行业
    /// </summary>
    dynamic var OtherIndustry = ""

    //MARK: -- 门店物业
    ///
    
    /// 经营名称
    ///
    
    
    dynamic var ManageName = ""
    ///
    
    /// 经营地址
    ///
    
    
    dynamic var ManageAddress = ""
    ///
    
    /// 主营业务
    ///
    
    
    dynamic var MainBusiness = ""
    ///
    
    /// 所属行业
    ///
    
    
    dynamic var Industry = ""
    ///
    
    /// 开业时间
    ///
    
    
    dynamic var OpeningTime = ""
    ///
    
    /// 门店个数
    ///
    
    
    dynamic var StoreCount = ""
    ///
    
    /// 营业面积
    ///
    
    
    dynamic var BusinessArea = ""
    ///
    
    /// 商户经营地段
    ///
    
    
    dynamic var StoreSection = ""
    ///
    
    /// 员工人数
    ///
    
    
    dynamic var Staff = ""
    ///
    
    /// 门店物业性质
    ///
    
    
    dynamic var PropertyNature = ""
    ///
    
    /// 每月租金
    ///
    
    
    dynamic var Monthly = ""
    ///
    
    /// 付租方式
    ///
    
    
    dynamic var PayMedthod = ""
    ///
    
    /// 房屋租赁起止日期
    ///
    
    
    dynamic var RentStartTime = ""
    ///
    
    /// 租赁到期日期
    ///
    
    
    dynamic var RentEndTime = ""
    ///
    
    ///  房东姓名
    ///
    
    
    dynamic var LandlordNmae = ""
    ///
    
    ///联系方式
    ///
    
    
    dynamic var LandlordPhone = ""
 
   //mark -- #region 卖方收款账户
    ///
    
    /// 开户名称
    ///
    
    
    dynamic var BankUserName = ""
    ///
    
    /// 开户行
    ///
    
    
    dynamic var BankName = ""
    ///
    
    /// 账户
    ///
    
    dynamic var CardCount = ""
    
    
    dynamic var BankCardID = ""
    ///
    
    /// 有无信用卡
    ///
    
    
    dynamic var IsHasCredit = ""
    ///
    
    /// 信用卡开户行
    ///
    
    
    dynamic var CreditBankName = ""
    ///
    
    /// 最高额度信用卡开卡行
    ///
    
    
    dynamic var HighestCardBank = ""
    ///
    
    /// 信用卡单卡最高额度
    ///
    
    
    dynamic var HighestLimit = ""
    ///
    
    /// 行用卡总额度
    ///
    
    
    dynamic var TotalAmount = ""
    ///
    
    /// 信用卡剩余总额度
    ///
    
    
    dynamic var TotalSurplus = ""
   //mark - #region  非同住亲友信息
    ///
    
    /// 亲友姓名
    ///
    
    
    dynamic var FName = ""
    ///
    
    /// 亲友手机
    ///
    
    
    dynamic var FPhone = ""
    ///
    
    /// 亲友联系地址
    ///
    
    
    dynamic var FAddress = ""
    ///
    
    /// 亲友固定电话
    ///
    
    
    dynamic var FTelephone = ""
    
    /*
    /// 还款期数
    /// </summary>
    dynamic var stagesNum = ""
    /// <summary>
    /// 社会信用代码证
    /// </summary>
    dynamic var socialcode = ""
    /// <summary>
    /// 组织机构代码证
    /// </summary>
    dynamic var organizationcode = ""
    /// <summary>
    /// 营业执照编号
    /// </summary>
    dynamic var businesscode = ""
    /// <summary>
    /// 经营性质
    /// </summary>
    dynamic var businessNature = ""
    /// <summary>
    /// 经营场所-省
    /// </summary>
    dynamic var businessPlaceProvince = ""
    /// <summary>
    /// 经营场所-市
    /// </summary>
    dynamic var businessPlaceCity = ""
    /// <summary>
    /// 经营场所-区
    /// </summary>
    dynamic var businessPlaceCountry = ""
    /// <summary>
    /// 经营场所-详细地址
    /// </summary>
    dynamic var businessPlaceAddress = ""
    /// <summary>
    /// 邮编
    /// </summary>
    dynamic var ZipCode = ""
    /// <summary>
    /// 公司电话
    /// </summary>
    dynamic var CompanyPhone = ""
    /// <summary>
    /// 关联企业
    /// </summary>
    dynamic var RelationCompany = ""
    
    //MARK: ------ 卖方法定代表经营主信息
    /// <summary>
    /// 申请人身份证号（公司法人）
    /// </summary>
    dynamic var CardId = ""
    /// <summary>
    /// 申请人固定电话（公司法人）
    /// </summary>
    dynamic var fixedTelephone = ""
    /// <summary>
    /// 法人联系地址-省
    /// </summary>
    dynamic var LegalProvince = ""
    /// <summary>
    /// 法人联系地址-市
    /// </summary>
    dynamic var LegalCity = ""
    /// <summary>
    /// 法人联系地址-区
    /// </summary>
    dynamic var LegalCountry = ""
    /// <summary>
    /// 法人联系地址-详细地址
    /// </summary>
    dynamic var LegalAddress = ""
    /// <summary>
    /// 法人主营业务月营业额（含现金收款）
    /// </summary>
    dynamic var LegalTurnoverMon = ""
    /// <summary>
    /// 法人经营业务实际年限
    /// </summary>
    dynamic var BussinessLifeNum = ""
    /// <summary>
    /// 法人主营业务名称
    /// </summary>
    dynamic var LegalBussinessName = ""
    /// <summary>
    /// 法人主营业务年收入
    /// </summary>
    dynamic var AnnualIncome = ""
    /// <summary>
    /// 其它业务
    /// </summary>
    dynamic var OtherBussinessName = ""
    /// <summary>
    /// 其它业务年收入
    /// </summary>
    dynamic var OtherAnnualIncome = ""
    
    //MARK: ------卖方收款账户信息
    /// <summary>
    /// 开户名称
    /// </summary>
    dynamic var OpeningBankName = ""
    /// <summary>
    /// 开户行地址
    /// </summary>
    dynamic var BankOfDepositPlace = ""
    /// <summary>
    /// 开户卡号
    /// </summary>
    dynamic var BankOfDepositCardId = ""
    
    //MARK: ------卖方门店资料
    /// <summary>
    /// 门店物业种类
    /// </summary>
    dynamic var StoreType = ""
    /// <summary>
    /// 经营名称（同注册地址相同则传空字符串）
    /// </summary>
    dynamic var NewBusinessName = ""
    /// <summary>
    /// 经营地址-省（同注册地址相同则传空字符串）
    /// </summary>
    dynamic var NewBusinessAddressProvince = ""
    /// <summary>
    /// 经营地址-市（同注册地址相同则传空字符串）
    /// </summary>
    dynamic var NewBusinessAddressCity = ""
    /// <summary>
    /// 经营地址-区（同注册地址相同则传空字符串）
    /// </summary>
    dynamic var NewBusinessAddressCountry = ""
    /// <summary>
    /// 经营地址-详细地址（同注册地址相同则传空字符串）
    /// </summary>
    dynamic var NewBusinessAddressAddress = ""
    /// <summary>
    /// 主营业务
    /// </summary>
    dynamic var PrimaryBusiness = ""
    /// <summary>
    /// 所属行业
    /// </summary>
    dynamic var Industry = ""
    /// <summary>
    /// 开业时间
    /// </summary>
    dynamic var OpeningTime = ""
    /// <summary>
    /// 门店个数
    /// </summary>
    dynamic var StoreCount = ""
    /// <summary>
    /// 营业面积
    /// </summary>
    dynamic var BusinessArea = ""
    /// <summary>
    /// 所处地段
    /// </summary>
    dynamic var StoreSection = ""
    /// <summary>
    /// 员工人数
    /// </summary>
    dynamic var Staff = ""
    /// <summary>
    /// 门店物业性质
    /// </summary>
    dynamic var PropertyNature = ""
    /// <summary>
    /// 月租
    /// </summary>
    dynamic var Monthly = ""
    /// <summary>
    /// 付租方式
    /// </summary>
    dynamic var PayMedthod = ""
    /// <summary>
    /// 租赁起始时间
    /// </summary>
    dynamic var RentStartTime = ""
    /// <summary>
    /// 租赁结束时间
    /// </summary>
    dynamic var RentEndTime = ""
    /// <summary>
    /// 房东姓名
    /// </summary>
    dynamic var LandlordNmae = ""
    
    
    /// <summary>
    /// 房东联系方式
    /// </summary>
    dynamic var LandlordPhone = ""
    
    
    //MARK: ------卖方（或法定代表人）信用卡信息
    /// <summary>
    /// 信用卡数量
    /// </summary>
    dynamic var CreditCardNumber = ""
    /// <summary>
    /// 最高额度信用卡开卡行
    /// </summary>
    dynamic var HighestCardBank = ""
    /// <summary>
    /// 最高额度
    /// </summary>
    dynamic var HighestLimit = ""
    /// <summary>
    /// 总额度
    /// </summary>
    dynamic var TotalAmount = ""
    /// <summary>
    /// 总剩余额度
    /// </summary>
    dynamic var TotalSurplus = ""
    
    //------非亲友同住信息------//
    /// <summary>
    /// 亲友姓名
    /// </summary>
    dynamic var QYname = ""
    /// <summary>
    /// 亲友手机号
    /// </summary>
    dynamic var QYphone = ""
    /// <summary>
    /// 亲友所在省
    /// </summary>
    dynamic var QYprovince = ""
    /// <summary>
    /// 亲友所在市
    /// </summary>
    dynamic var QYcity = ""
    /// <summary>
    /// 亲友所在区
    /// </summary>
    dynamic var QYcountry = ""
    /// <summary>
    /// 亲友所在具体地址
    /// </summary>
    dynamic var QYaddress = ""
    /// <summary>
    /// 亲友固定电话
    /// </summary>
    dynamic var QYtelephone = ""
 
    */
    override class func primaryKey() -> String? {
        return "requestRealmID"
    }


}
