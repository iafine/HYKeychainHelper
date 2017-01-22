//
//  HYAddKeychainController.swift
//  HYKeychainHelperDemo
//
//  Created by hyyy on 2017/1/22.
//  Copyright © 2017年 hyyy. All rights reserved.
//

import UIKit

class HYAddKeychainController: UIViewController {

    let accountLabel: UILabel = {
        let label = UILabel (frame: CGRect.zero)
        label.textColor = UIColor.lightGray
        label.text = "ACCOUNT"
        label.font = UIFont.systemFont(ofSize: 14.0)
        
        return label
    }()
    
    let accountField: UITextField = {
        let textField = UITextField (frame: CGRect.zero)
        textField.placeholder = "Enter a account name"
        textField.borderStyle = .none
        textField.backgroundColor = UIColor.white
        return textField
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel (frame: CGRect.zero)
        label.textColor = UIColor.lightGray
        label.text = "PASSWORD"
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    let passwordField: UITextField = {
        let textField = UITextField (frame: CGRect.zero)
        textField.placeholder = "Enter a password"
        textField.borderStyle = .none
        textField.backgroundColor = UIColor.white
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add Account"
        self.view.backgroundColor = UIColor (red: 239 / 255, green: 239 / 255, blue: 244 / 255, alpha: 1.0)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem (barButtonSystemItem: .cancel, target: self, action: #selector (clickedCancelBtnHandler))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (barButtonSystemItem: .save, target: self, action: #selector (clickedDoneBtnHandler))
        
        self.view.addSubview(self.accountLabel)
        self.view.addSubview(self.accountField)
        self.view.addSubview(self.passwordLabel)
        self.view.addSubview(self.passwordField)
        
        self.accountField.addTarget(self, action: #selector (textFieldChanged), for: .editingChanged)
        self.passwordField.addTarget(self, action: #selector (textFieldChanged), for: .editingChanged)
        
        initLayout()
    }

    func initLayout() {
        self.accountLabel.frame = CGRect (x: 10, y: 64 + 40, width: UIScreen.main.bounds.width - 20, height: 25)
        self.accountField.frame = CGRect (x: 0, y: self.accountLabel.frame.origin.y + 30, width: UIScreen.main.bounds.width, height: 35)
        self.passwordLabel.frame = CGRect (x: 10, y: self.accountField.frame.origin.y + 50, width: UIScreen.main.bounds.width - 20, height: 25)
        self.passwordField.frame = CGRect (x: 0, y: self.passwordLabel.frame.origin.y + 30, width: UIScreen.main.bounds.width, height: 35)
        
        updateSaveButtonState()
    }
}

// MARK: - Events
extension HYAddKeychainController {
    func clickedCancelBtnHandler() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func clickedDoneBtnHandler() {
        HYKeychainHelper.set(password: self.passwordField.text, service: ViewController.serviceName, account: self.accountField.text)
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldChanged() {
        updateSaveButtonState()
    }
    
    func updateSaveButtonState() {
        guard isViewLoaded else {
            return
        }
        
        // Enable the save button if both account and password fields contain text.
        if let newAccount = accountField.text, let newPassword = passwordField.text, !newAccount.isEmpty && !newPassword.isEmpty {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}
