//
//  FileUtils.swift
//  FMDBDemo
//
//  Created by Frank.Chen on 2017/2/25.
//  Copyright © 2017年 Frank.Chen. All rights reserved.
//

import UIKit

class FileUtils: NSObject {
    
    private static var fileUtils: FileUtils?
    
    static func sharedInstance() -> FileUtils {
        if self.fileUtils == nil {
            self.fileUtils = FileUtils()
        }
        
        return self.fileUtils!
    }
    
    private override init() {
        
    }
    
    /// 將bundle的sqlite複製至documents
    ///
    /// - Parameter fileName: sqlite名稱
    func copyFile(toDocuments fileName: String) {
        // 取得documents file path
        let filePath: String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/" + fileName
        
        // 取得bundle下的檔案路徑
        let fromPath: String? = Bundle.main.path(forResource: fileName, ofType: "sqlite")!
        
        let fileManager: FileManager = FileManager.default
        
        // 判斷documents是否已存在該檔案
        if !fileManager.fileExists(atPath: filePath) {
            do {
                try fileManager.copyItem(atPath: fromPath!, toPath: filePath)
                print("file copy to: \(filePath)")
            } catch {
                print(error)
            }
        } else {
            print("DID-NOT copy db file, file allready exists at path:\(filePath)")
        }
    }
    
}
