//
//  Department.swift
//  FMDBDemo
//
//  Created by Frank.Chen on 2018/2/3.
//  Copyright © 2018年 Frank.Chen. All rights reserved.
//

import UIKit

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
