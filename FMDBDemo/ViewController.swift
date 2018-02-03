//
//  ViewController.swift
//  FMDBDemo
//
//  Created by Frank.Chen on 2017/2/25.
//  Copyright © 2017年 Frank.Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var departmentDataList: [Department] = [Department]()
    var didSelectIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.departmentDataList = Dao.shared.queryData()
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController: DetailViewController = segue.destination as! DetailViewController
        
        if segue.identifier == "AddSegue" {
            // 點選新增 BarButton
            detailViewController.isAddStatus = true
        } else if segue.identifier == "DetailSegue" {
            // 點選 Cell 進來修改模式
            detailViewController.isAddStatus = false
            detailViewController.department = self.departmentDataList[self.didSelectIndex!]            
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectIndex = indexPath.row
        self.performSegue(withIdentifier: "DetailSegue", sender: nil)
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.departmentDataList[indexPath.row].departmentChNm
        cell.detailTextLabel?.text = self.departmentDataList[indexPath.row].departmentEnNm
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.departmentDataList.count
    }
}
