//
//  DepartmentDetailVC.swift
//  FMDBDemo
//
//  Created by Frank.Chen on 2017/2/25.
//  Copyright © 2017年 Frank.Chen. All rights reserved.
//

import UIKit

class DepartmentDetailVC: UIViewController {
    
    var department: Department?
    var deptChNmLbl: UILabel?
    var deptEnNmLbl: UILabel?
    var deptChNmTxtFld: UITextField?
    var deptEnNmTxtFld: UITextField?
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = self.department == nil ? "新增" : "修改"
        
        // 設定部門中文名稱label
        self.deptChNmLbl = UILabel()
        self.deptChNmLbl?.frame = CGRect(x: 10, y: 164, width: self.view.frame.size.width / 2 - 10, height: 50)
        self.deptChNmLbl?.text = "部門中文名稱："
        self.deptChNmLbl?.font = UIFont.systemFont(ofSize: (self.deptChNmLbl?.frame.size.height)! * 0.4)
        self.deptChNmLbl?.textAlignment = NSTextAlignment.right
        self.view.addSubview(self.deptChNmLbl!)
        
        // 設定部門中文名稱textField
        self.deptChNmTxtFld = UITextField()
        self.deptChNmTxtFld?.frame = CGRect(x: self.view.frame.size.width / 2, y: 164, width: self.view.frame.size.width / 2 - 10, height: 50)
        self.deptChNmTxtFld?.font = UIFont.systemFont(ofSize: (self.deptChNmLbl?.frame.size.height)! * 0.4)
        self.deptChNmTxtFld?.textAlignment = NSTextAlignment.left
        self.deptChNmTxtFld?.clearButtonMode = UITextFieldViewMode.unlessEditing // 清除按鈕
        self.deptChNmTxtFld?.borderStyle = UITextBorderStyle.roundedRect
        self.deptChNmTxtFld?.text = self.department == nil ? "" : self.department?.departmentChNm
        self.deptChNmTxtFld?.placeholder = self.department == nil ? "請輸入部門中文名稱" : ""
        self.view.addSubview(self.deptChNmTxtFld!)
        
        // 設定部門英文名稱label
        self.deptEnNmLbl = UILabel()
        self.deptEnNmLbl?.frame = CGRect(x: 10, y: (self.deptChNmLbl?.frame.origin.y)! + (self.deptChNmLbl?.frame.size.height)! + 10, width: self.view.frame.size.width / 2 - 10, height: 50)
        self.deptEnNmLbl?.text = "部門英文名稱："
        self.deptEnNmLbl?.font = UIFont.systemFont(ofSize: (self.deptChNmLbl?.frame.size.height)! * 0.4)
        self.deptEnNmLbl?.textAlignment = NSTextAlignment.right
        self.view.addSubview(self.deptEnNmLbl!)
        
        // 設定部門英文名稱textField
        self.deptEnNmTxtFld = UITextField()
        self.deptEnNmTxtFld?.frame = CGRect(x: self.view.frame.size.width / 2, y: (self.deptChNmLbl?.frame.origin.y)! + (self.deptChNmLbl?.frame.size.height)! + 10, width: self.view.frame.size.width / 2 - 10, height: 50)
        self.deptEnNmTxtFld?.font = UIFont.systemFont(ofSize: (self.deptChNmLbl?.frame.size.height)! * 0.4)
        self.deptEnNmTxtFld?.textAlignment = NSTextAlignment.left
        self.deptEnNmTxtFld?.clearButtonMode = UITextFieldViewMode.unlessEditing // 清除按鈕
        self.deptEnNmTxtFld?.borderStyle = UITextBorderStyle.roundedRect
        self.deptEnNmTxtFld?.text = self.department == nil ? "" : self.department?.departmentEnNm
        self.deptEnNmTxtFld?.placeholder = self.department == nil ? "請輸入部門英文名稱" : ""
        self.view.addSubview(self.deptEnNmTxtFld!)
        
        // 生成新增或修改的按鈕
        let addOrEditBtn: UIButton = UIButton()
        addOrEditBtn.frame = CGRect(x: 10, y: (self.deptEnNmTxtFld?.frame.origin.y)! + (self.deptEnNmTxtFld?.frame.size.height)! + 10, width: self.view.frame.size.width - 20, height: 50)
        addOrEditBtn.titleLabel?.font = UIFont.systemFont(ofSize: addOrEditBtn.frame.size.height * 0.4)
        addOrEditBtn.setTitle(self.department == nil ? "新增" : "修改", for: .normal)
        addOrEditBtn.setTitleColor(UIColor.white, for: .normal)
        addOrEditBtn.layer.cornerRadius = 10
        addOrEditBtn.backgroundColor = UIColor.gray
        addOrEditBtn.addTarget(self, action: #selector(DepartmentDetailVC.onClickAddOrEditBtn(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(addOrEditBtn)
        
    }
    
    /// 點選新增或修改按鈕
    ///
    /// - Parameter sender: UIButton
    func onClickAddOrEditBtn(_ sender: UIButton) {
        // 修改模式
        if self.department != nil {
            Dao.sharedInstance().updateData(withDepartmentId: (self.department?.departmentId)!, departmentChineseName: (self.deptChNmTxtFld?.text)!, departmentEnglistName: (self.deptEnNmTxtFld?.text)!)
        } else {
            // 新增模式
            Dao.sharedInstance().insertData(withDepartmentChineseName: (self.deptChNmTxtFld?.text)!, departmentEnglishName: (self.deptEnNmTxtFld?.text)!)
        }
        
        self.showMsg(message: self.department != nil ? "修改成功" : "新增成功")
    }
    
    // 提示是否更新最新版本
    func showMsg(message: String) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "確定", style: .default, handler: nil)
        
        alertController.addAction(confirm)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
