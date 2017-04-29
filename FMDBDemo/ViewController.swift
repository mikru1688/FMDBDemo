//
//  ViewController.swift
//  FMDBDemo
//
//  Created by Frank.Chen on 2017/2/25.
//  Copyright © 2017年 Frank.Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var departmentDatas: [Department]?
    var departmentTV: UITableView!
    var departmentDetailVC: DepartmentDetailVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "FMDBDemo"
        
        // 新增按鈕
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(ViewController.goAdd(_:))), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 查詢資料
        self.departmentDatas = Dao.shared.queryData()
        
        if self.departmentDatas != nil {
            if self.departmentTV == nil {
                self.departmentTV = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .plain)
                self.departmentTV.delegate = self
                self.departmentTV.dataSource = self
                self.view.addSubview(self.departmentTV)
            } else {
                self.departmentTV.reloadData()
            }            
        }
    }
    
    // MARK: - Delegate
    // ---------------------------------------------------------------------
    // 設定表格section的列數
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.departmentDatas?.count)!
    }
    
    // 設定cell的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 6
    }
    
    // 刪除資料必要實作方法
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    // 如果沒實作這個方法紅色按鈕不會出現
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // 刪除
        if editingStyle == UITableViewCellEditingStyle.delete {
            Dao.shared.deleteData(withDepartmentId: (self.departmentDatas?[indexPath.row].departmentId)!) // 刪除db資料
            self.departmentDatas?.remove(at: indexPath.row) // 移除集合裡面的資料
            tableView.deleteRows(at: [indexPath as IndexPath], with: .fade) // 移除畫面上tableView的資料
        }
    }
    
    // 表格的儲存格設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var departmentCell = tableView.dequeueReusableCell(withIdentifier: "departmentCell")
        if departmentCell == nil {
            departmentCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "departmentCell")
            departmentCell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            departmentCell?.selectionStyle = UITableViewCellSelectionStyle.none
            departmentCell?.textLabel?.font = UIFont.systemFont(ofSize: departmentCell!.frame.height * 0.6)
        }
        
        departmentCell!.textLabel?.text = self.departmentDatas?[indexPath.row].departmentChNm
        departmentCell!.detailTextLabel?.text = self.departmentDatas?[indexPath.row].departmentEnNm
        
        return departmentCell!
    }
    
    // 點選儲存格事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.departmentDetailVC = DepartmentDetailVC()
        self.departmentDetailVC?.department = self.departmentDatas?[indexPath.row]
        self.navigationController?.pushViewController(self.departmentDetailVC!, animated: true)
    }
    
    // 新增頁面
    func goAdd(_ sender: UIBarButtonItem) {
        self.departmentDetailVC = DepartmentDetailVC()        
        self.navigationController?.pushViewController(self.departmentDetailVC!, animated: true)
    }
    
}

