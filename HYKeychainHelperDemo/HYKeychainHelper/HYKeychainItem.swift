//
//  HYKeychainItem.swift
//  Quick-Start-iOS
//
//  Created by hyyy on 2017/1/16.
//  Copyright © 2017年 hyyy. All rights reserved.
//

import Foundation

enum KeychainError: Error {
    case itemNotFound
    case unexpectedItemData
    case unhandledError(status: OSStatus)
}

struct HYKeychainItem {
    
    /// kSecAttrService
    var service: String?
    
    /// kSecAttrAccount
    var account: String?
    
    /// kSecAttrAccessGroup
    var accessGroup: String?
    
    var password: String?
    
    var passwordData: Data?
    
    init(service: String? = nil, account: String? = nil) {
        self.service = service
        self.account = account
    }
    
    /// save a keychain item.
    ///
    /// - Throws: unhandledError
    mutating func save() throws {
        var pwdData: Data?
        if (password != nil) {
            pwdData = password?.data(using: String.Encoding.utf8)
        }else {
            pwdData = passwordData
        }
        
        do {
            // 检查keychain里面是否存在，如果存在，则更新
            try _ = queryPassword()
            
            var attributesToUpdate = [String : AnyObject]()
            attributesToUpdate[kSecValueData as String] = pwdData as AnyObject?
            let query = HYKeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            guard status == noErr else {
                throw KeychainError.unhandledError(status: status)
            }
        } catch KeychainError.itemNotFound {
            // 不存在的话，添加到keychain中
            var newItem = HYKeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
            newItem[kSecValueData as String] = pwdData as AnyObject?
            
            let status = SecItemAdd(newItem as CFDictionary, nil)
            guard status == noErr else {
                throw KeychainError.unhandledError(status: status)
            }
        }
    }
    
    /// delete a keychain item
    ///
    /// - Throws: unhandledError
    func delete() throws {
        let query = HYKeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == noErr || status == errSecItemNotFound else {
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    /// query a keychain password
    ///
    /// - Returns: password
    /// - Throws: unhandledError
    mutating func queryPassword() throws {
        var query = HYKeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue
        
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
        guard status == noErr else {
            throw KeychainError.unhandledError(status: status)
        }
        
        guard let existItem = queryResult as? [String : AnyObject],
            let queryPasswordData = existItem[kSecValueData as String] as? Data,
            let queryPassword = String(data: queryPasswordData, encoding: String.Encoding.utf8) else {
            throw KeychainError.unexpectedItemData
        }
        password = queryPassword
        passwordData = queryPasswordData
        
    }
    
    /// query all keychain item
    ///
    /// - Returns: all items
    /// - Throws: unhandledError
    func queryAll() throws -> Array<[String : AnyObject]> {
        var query = HYKeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitAll
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue
        
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        // If no items were found, return an empty array.
        guard status != errSecItemNotFound else {
            return []
        }
        
        // Throw an error if an unexpected status was returned.
        guard status == noErr else {
            throw KeychainError.unhandledError(status: status)
        }
        
        // Cast the query result to an array of dictionaries.
        guard let resultData = queryResult as? [[String : AnyObject]] else {
            throw KeychainError.unexpectedItemData
        }
        return resultData
    }
}

// MARK: - Private Methods
extension HYKeychainItem {
    fileprivate static func keychainQuery(withService service: String? = nil, account: String? = nil, accessGroup: String? = nil) -> [String : AnyObject] {
        var query = [String : AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        
        if let service = service {
            query[kSecAttrService as String] = service as AnyObject?
        }
        
        if let account = account {
            query[kSecAttrAccount as String] = account as AnyObject?
        }
        
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }
        
        return query
    }
}
