//
//  Dao.swift
//  FMDBDemo
//
//  Created by Frank.Chen on 2017/2/25.
//  Copyright © 2017年 Frank.Chen. All rights reserved.
//

/// 單例(singleton)
class Dao: NSObject {
    
    private static var dao: Dao?
    
    var fileName: String = "DEPARTMENT_DATA" // sqlite name
    var filePath: String = "" // sqlite path
    var database: FMDatabase! // FMDBConnection
    
    static func sharedInstance() -> Dao {
        if self.dao == nil {
            self.dao = Dao()
        }
        
        return self.dao!
    }
    
    private override init() {
        super.init()
        
        // 取得sqlite在documents下的路徑(開啟連線用)
        self.filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/" + self.fileName
    }
    
    deinit {
        print("deinit: \(self)")
    }    
    
    /// 取得sqlite連線
    ///
    /// - Returns: Bool
    func openConnection() -> Bool {
        var isOpen: Bool = false
        
        self.database = FMDatabase(path: self.filePath)
        
        if self.database != nil {
            if self.database.open() {
                isOpen = true
            } else {
                print("Could not get the connection.")
            }
        }
        
        return isOpen
        
    }
    
    /// 新增部門資料
    ///
    /// - Parameters:
    ///   - departmentEnglistName: 部門中文名稱
    ///   - departmentChineseName: 部門英文名稱
    func insertData(withDepartmentChineseName departmentChineseName: String, departmentEnglishName: String) {
        
        if self.openConnection() {
            let insertSQL: String = "INSERT INTO DEPARTMENT (DEPARTMENT_ID, DEPT_CH_NM, DEPT_EN_NM) VALUES((SELECT IFNULL(MAX(DEPARTMENT_ID), 0) + 1 FROM DEPARTMENT), '\(departmentChineseName)', '\(departmentEnglishName)')"
            
            if !self.database.executeStatements(insertSQL) {
                print("Failed to insert initial data into the database.")
                print(database.lastError(), database.lastErrorMessage())
            }
            
            self.database.close()
        }
    }
    
    /// 更新部門資料
    ///
    /// - Parameters:
    ///   - departmentId: 部門ID
    ///   - departmentEnglistName: 部門中文名稱
    ///   - departmentChineseName: 部門英文名稱
    func updateData(withDepartmentId departmentId: Int, departmentChineseName: String, departmentEnglistName: String) {
        if self.openConnection() {
            let updateSQL: String = "UPDATE DEPARTMENT SET DEPT_CH_NM = ?, DEPT_EN_NM = ? WHERE DEPARTMENT_ID = ?"
            
            do {
                try self.database.executeUpdate(updateSQL, values: [departmentChineseName, departmentEnglistName, departmentId])
            } catch {
                print(error.localizedDescription)
            }
            
            self.database.close()
        }
    }
    
    /// 取得部門的所有資料
    ///
    /// - Returns: 部門資料
    func queryData() -> [Department] {
        var departmentDatas: [Department] = [Department]()
        
        if self.openConnection() {
            let querySQL: String = "SELECT * FROM DEPARTMENT"
            
            do {
                let dataLists: FMResultSet = try database.executeQuery(querySQL, values: nil)
                
                while dataLists.next() {
                    let department: Department = Department(departmentId: Int(dataLists.int(forColumn: "DEPARTMENT_ID")), departmentChNm: dataLists.string(forColumn: "DEPT_CH_NM"), departmentEnNm: dataLists.string(forColumn: "DEPT_EN_NM"))
                    departmentDatas.append(department)
                }
            } catch {
                print(error.localizedDescription)
            }                        
        }
        
        return departmentDatas
    }
    
    /// 刪除部門資料
    ///
    /// - Parameter departmentId: 部門ID
    func deleteData(withDepartmentId departmentId: Int) {
        if self.openConnection() {
            let deleteSQL: String = "DELETE FROM DEPARTMENT WHERE DEPARTMENT_ID = ?"
            
            do {
                try self.database.executeUpdate(deleteSQL, values: [departmentId])
            } catch {
                print(error.localizedDescription)
            }
            
            self.database.close()
        }
    }
    
}
