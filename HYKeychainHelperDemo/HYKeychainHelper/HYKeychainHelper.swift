//
//  HYKeychainHelper.swift
//  Quick-Start-iOS
//
//  Created by hyyy on 2017/1/18.
//  Copyright © 2017年 hyyy. All rights reserved.
//

import Foundation

struct HYKeychainHelper {
    
    static func password(service: String?, account: String?, accessGroup: String? = nil) -> String? {
        var item = HYKeychainItem (service: service, account: account)
        item.accessGroup = accessGroup
        do {
            try item.queryPassword()
        }catch {
            fatalError("Error fetching password item - \(error)")
        }
        return item.password
    }
    
    static func passwordData(service: String?, account: String?, accessGroup: String? = nil) -> Data? {
        var item = HYKeychainItem (service: service, account: account)
        item.accessGroup = accessGroup
        do {
            try item.queryPassword()
        }catch {
            fatalError("Error fetching passwordData item - \(error)")
        }
        return item.passwordData
    }
    
    static func deletePassword(service: String?, account: String?, accessGroup: String? = nil) {
        var item = HYKeychainItem (service: service, account: account)
        item.accessGroup = accessGroup
        do {
            try item.delete()
        } catch {
            fatalError("Error deleting password item - \(error)")
        }
    }
    
    static func set(password: String?, service: String?, account: String?, accessGroup: String? = nil) {
        var item = HYKeychainItem (service: service, account: account)
        item.accessGroup = accessGroup
        item.password = password
        do {
            try item.save()
        } catch {
            fatalError("Error setting password item - \(error)")
        }
    }
    
    static func set(passwordData: Data?, service: String?, account: String?, accessGroup: String? = nil) {
        var item = HYKeychainItem (service: service, account: account)
        item.accessGroup = accessGroup
        item.passwordData = passwordData
        do {
            try item.save()
        }catch {
            fatalError("Error setting password item - \(error)")
        }
    }
    
    static func allAccount() -> Array<[String : AnyObject]> {
        return allAccounts(forService: nil)
    }
    
    static func allAccounts(forService service: String?) -> Array<[String : AnyObject]> {
        var item = HYKeychainItem ()
        item.service = service
        var allAccountsArr: Array<[String : AnyObject]>
        do {
            try allAccountsArr = item.queryAll()
        } catch {
            fatalError("Error setting password item - \(error)")
        }
        return allAccountsArr
    }
}
