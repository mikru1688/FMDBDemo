//
//  DetailViewController.swift
//  FMDBDemo
//
//  Created by Frank.Chen on 2018/2/3.
//  Copyright © 2018年 Frank.Chen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var chineseTextField: UITextField!
    @IBOutlet weak var englishTextField: UITextField!
    @IBOutlet weak var addOrEditButton: UIButton!
    
    var isAddStatus: Bool = false    
    var department: Department?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 若是修改模式則要顯示由上一頁帶入的資料
        if !self.isAddStatus {
            self.chineseTextField.text = self.department?.departmentChNm
            self.englishTextField.text = self.department?.departmentEnNm
            self.addOrEditButton.setTitle("修改", for: UIControlState.normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 點選新增按鈕
    ///
    /// - Parameter sender: _
    @IBAction func pressAddButton(_ sender: UIButton) {
        if self.isAddStatus {
            // 新增
            Dao.shared.insertData(withDepartmentChineseName: self.chineseTextField.text!, departmentEnglishName: self.englishTextField.text!)
            self.showMsg(message: "新增成功")
        } else {
            // 修改
            Dao.shared.updateData(withDepartmentId: (self.department?.departmentId)!, departmentChineseName: self.chineseTextField.text!, departmentEnglistName: self.englishTextField.text!)
            self.showMsg(message: "修改成功")
        }
    }
    
    
    /// 訊息提示
    ///
    /// - Parameter message: 提示的訊息
    func showMsg(message: String) {
        let alertController: UIAlertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let confirm: UIAlertAction = UIAlertAction(title: "確定", style: .default, handler: nil)
        alertController.addAction(confirm)
        
        self.present(alertController, animated: true, completion: nil)
    }

}
