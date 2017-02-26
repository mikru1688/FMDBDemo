//
//  Department.swift
//  FMDBDemo
//
//  Created by Frank.Chen on 2017/2/25.
//  Copyright © 2017年 Frank.Chen. All rights reserved.
//

/// 部門資料
class Department: NSObject {
    
    var departmentId: Int
    var departmentChNm: String
    var departmentEnNm: String
    
    init(departmentId: Int, departmentChNm: String, departmentEnNm: String) {
        self.departmentId = departmentId
        self.departmentChNm = departmentChNm
        self.departmentEnNm = departmentEnNm
    }
}
