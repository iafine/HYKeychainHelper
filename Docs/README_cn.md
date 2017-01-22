# HYKeychainHelper


  [![Language](https://img.shields.io/badge/Swift-3.0-orange.svg)]()
  [![GitHub license](https://img.shields.io/cocoapods/l/HYKeychainHelper.svg)](https://github.com/castial/HYKeychainHelper/blob/master/LICENSE)
  [![Pod version](http://img.shields.io/cocoapods/v/HYKeychainHelper.svg)](https://cocoapods.org/pods/HYKeychainHelper)

HYKeychainHelper是一个iOS系统Keychain操作的工具类，可以非常方便地实现获取账户、获取密码、添加密码和删除密码。

## 要求

- Swift 3
- iOS 10.0+
- Xcode 8+

## CocoaPods

[CocoaPods](http://cocoapods.org)是iOS最常用的依赖管理工具，您可以用下面的命令安装它:

```bash
$ gem install cocoapods
```

然后在项目根目录创建`Podfile`文件，写入下面内容：

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

pod 'HYKeychainHelper'
```

最后，命令行运行下面命令即可完成安装：

```bash
$ pod install
```

## 手动安装

下载该项目文件，将```/HYKeychainHelper```文件夹拖到您的项目中去。

## 基本介绍
HYKeychainHelper使用类似与SSKeychain，所以可以方便上手。为了测试Keychain功能，我专门提供了一个简单的Demo。您可以把bundle ID改成自己的，另外需要打开Keychain支持，如果还有其他问题，可以提交一个issue，我会第一时间去回复的。

#### 用法

HYKeychainHelper的用法很简单，所有外部方法都是以类方法来提供的。具体如下：

```swift
/// query account's password
HYKeychainHelper.password(service: "your_service_name", account: "your_account_name")

/// add or update an account
HYKeychainHelper.set(password: "your_password", service: "your_service_name", account: "your_account_name")

/// delete an account
HYKeychainHelper.deletePassword(service: "your_service_name", account: "your_account_name")

/// all accounts
HYKeychainHelper.allAccounts(forService: "your_service_name")
```

>对于更多的用法，请查看`HYKeychainHelper`获取更多细节。


## Swift版本要求

`HYKeychainHelper`采用Swift 3开发完成，所以您的Swift版本必须是Swift 3。

## 交流

- 如果您遇到问题或者是需要帮助，可以创建issue，我会第一时间为您解答；
- 如果您需要一些优化，可以创建issue讨论；
- 如果您想提交贡献，请发布一个pull request.

## MIT License
HYKeychainHelper is available under the MIT license. See the LICENSE file for more info.
