//
//  ViewController.swift
//  HYKeychainHelperDemo
//
//  Created by hyyy on 2017/1/22.
//  Copyright © 2017年 hyyy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView (frame: CGRect (x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        return tableView
    }()
    
    static let serviceName: String = "HYAppService"
    
    var dataArray = Array<[String : String]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "KeychainAccounts"
        self.view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (barButtonSystemItem: .add, target: self, action: #selector(clickedAddBtnHandler))
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.dataArray.removeAll()
        let accounts = HYKeychainHelper.allAccounts(forService: ViewController.serviceName)
        for account in accounts {
            let accountName = account["acct"] as! String
            let passwordName = HYKeychainHelper.password(service: ViewController.serviceName, account: accountName)
            let dic = ["account" : accountName, "password" : passwordName]
            self.dataArray.append(dic as! [String : String])
        }
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell (style: .value1, reuseIdentifier: "cell")
        let dic = self.dataArray[indexPath.row];
        cell.textLabel?.text = dic["account"]
        cell.detailTextLabel?.text = dic["password"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { action, indexPath in
            // Try to delete the item from the keychain.
            let dic = self.dataArray[indexPath.row]
            
            HYKeychainHelper.deletePassword(service: ViewController.serviceName, account: dic["account"])
            
            // Delete the item from the `passwordItems` array.
            self.dataArray.remove(at: indexPath.row)
            
            // Delete the item from the table view
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }
}

// MARK: - Events
extension ViewController {
    func clickedAddBtnHandler() {
        let addVC = UINavigationController (rootViewController: HYAddKeychainController ())
        self.present(addVC, animated: true, completion: nil)
    }
}

