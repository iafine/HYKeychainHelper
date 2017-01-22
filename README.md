# HYKeychainHelper


  [![Language](https://img.shields.io/badge/Swift-3.0-orange.svg)]()
  [![GitHub license](https://img.shields.io/cocoapods/l/HYKeychainHelper.svg)](https://github.com/castial/HYKeychainHelper/blob/master/LICENSE)
  [![Pod version](http://img.shields.io/cocoapods/v/HYKeychainHelper.svg)](https://cocoapods.org/pods/HYKeychainHelper)

HYKeychainHelper is a simple tool for accessing accounts, getting passwords, setting passwords, and deleting passwords using the system Keychain on iOS.

## Requirements

- Swift 3
- iOS 10.0+
- Xcode 8+

## CocoaPods


[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

Then create `Podfile` file into your Xcode project, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

pod 'HYKeychainHelper'
```

Finially, you will complete it with the following command:

```bash
$ pod install
```

## Manually

Download and drop ```/HYKeychainHelper``` folder in your project.

## Introdution

The usage of HYKeychainHelper is similar to SSKeychain, so you can easily get started. I specifically provide a simple Demo in order to test HYKeychainHelper function. You can use your bundle ID for testing. Note the bundle ID need Keychain support. if you have question about HYKeychainHelper, you can submit an issue. I will reply to the first time.

#### Usage

It's very simple to use HYKeychainHelper, all external methods are provided in a class method. details as follows:

```swift
/// query account's password
HYKeychainHelper.password(service: "your_service_name", account: "your_account_name")

/// add or update an account
HYKeychainHelper.set(password: "your_password", service: "your_service_name", account: "your_account_name")

/// delete an account
HYKeychainHelper.deletePassword(service: "your_service_name", account: "your_account_name")

/// all accounts
HYKeychainHelper.allAccounts(forService: "your_service_name")

>For more usage scenarios, please refer to `HYKeychainHelper` for details.

```

## Swift Version

`HYKeychainHelper` is developed with Swift 3, so your Swift version must be Swift 3.

## Communicate

- If you need help or you'd like to ask a general question, open an issue;
- If you found a bug, open an issue;
- If you have a feature request, open an issue;
- If you want to contribute, submit a pull request.

## MIT License
HYKeychainHelper is available under the MIT license. See the LICENSE file for more info.
