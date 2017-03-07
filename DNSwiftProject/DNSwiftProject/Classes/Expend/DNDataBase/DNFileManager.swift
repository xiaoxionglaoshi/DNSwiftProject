//
//  DNFileManager.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/27.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

class DNFileManager {
    
    // 错误类型
    private enum FileErrors: Error {
        case jsonNotSerialized
        case fileNotSaved
        case imageNotConvertedToData
        case fileNotRead
        case fileNotFound
    }
    
    // MARK: 文件类型
    enum FileExtension: String {
        case txt = ".txt"
        case jpg = ".jpg"
        case json = ".json"
    }
    
    // MARK: 私有属性
    private let directory: FileManager.SearchPathDirectory
    private let directoryPath: String
    private let fileManager = FileManager.default
    private let fileName: String
    private let filePath: String
    private let fullyQualifiedPath: String
    private let subDirectory: String
    
    // MARK: 公共属性
    var fileExists: Bool {
        get {
            return fileManager.fileExists(atPath: fullyQualifiedPath)
        }
    }
    
    // 目录是否存在
    var directoryExists: Bool {
        get {
            var isDir = ObjCBool(true)
            return fileManager.fileExists(atPath: filePath, isDirectory: &isDir )
        }
    }
    
    /**
     初始化
     
     :param: fileName      文件名
     :param: fileExtension 文件类型
     :param: directory     子目录
     :param: saveDirectory 指定NSSearchPathDirectory文件保存
     
     */
    init(fileName: String, fileExtension: FileExtension, subDirectory: String = "", directory: FileManager.SearchPathDirectory = .documentDirectory) {
        self.fileName = fileName + fileExtension.rawValue
        self.subDirectory = "/\(subDirectory)"
        self.directory = directory
        self.directoryPath = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true)[0]
        self.filePath = directoryPath + self.subDirectory
        self.fullyQualifiedPath = "\(filePath)/\(self.fileName)"
        createDirectory()
    }
    
    // 如果所需的目录不存在,则创建它。
    private func createDirectory() {
        if !directoryExists {
            do {
                try fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: false, attributes: nil)
            }
            catch {
                print("An Error was generated creating directory")
            }
        }
    }
    
    // MARK: methods
    
    // 文本内容保存到文件
    func saveFileWith(fileContents: String) throws{
        
        do {
            try fileContents.write(toFile: fullyQualifiedPath, atomically: true, encoding: .utf8)
        }
        catch  {
            throw error
        }
    }
    
    // 图片内容保存到文件
    func saveFileWith(image: UIImage) throws {
        guard let data = UIImageJPEGRepresentation(image, 1.0) else {
            throw FileErrors.imageNotConvertedToData
        }
        if !fileManager.createFile(atPath: fullyQualifiedPath, contents: data, attributes: nil){
            throw FileErrors.fileNotSaved
        }
    }
    
    // JSON数据保存到文件
    func saveFileWith(dataForJson: AnyObject) throws {
        do {
            let jsonData = try convertObjectTo(data: dataForJson)
            if !fileManager.createFile(atPath: fullyQualifiedPath, contents: jsonData, attributes: nil){
                throw FileErrors.fileNotSaved
            }
        } catch {
            print(error)
            throw FileErrors.fileNotSaved
        }
        
    }
    
    // 读取文件中内容
    func getContentsOfFile() throws -> String {
        guard fileExists else {
            throw FileErrors.fileNotFound
        }
        var returnString:String
        do {
            returnString = try String(contentsOfFile: fullyQualifiedPath, encoding: .utf8)
        } catch {
            throw FileErrors.fileNotRead
        }
        return returnString
    }
    
    // 读取图片
    func getImage() throws -> UIImage {
        guard fileExists else {
            throw FileErrors.fileNotFound
        }
        guard let image = UIImage(contentsOfFile: fullyQualifiedPath) else {
            throw FileErrors.fileNotRead
        }
        return image
    }
    
    // 读取JSON数据
    func getJSONData() throws -> Dictionary<String, Any> {
        guard fileExists else {
            throw FileErrors.fileNotFound
        }
        do {
            let url = URL(fileURLWithPath: fullyQualifiedPath)
            let data = try Data(contentsOf: url)
            let jsonData = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as! Dictionary<String, Any>
            return jsonData
        } catch {
            throw FileErrors.fileNotRead
        }
        
    }
    
    // NSData转换为Json数据
    private func convertObjectTo(data: AnyObject) throws -> Data {
        do {
            let newData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            return newData
        }
        catch {
            print("Error writing data: \(error)")
        }
        throw FileErrors.jsonNotSerialized
    }
}
