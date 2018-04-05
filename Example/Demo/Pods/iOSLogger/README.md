# iOSLogger

[![CI Status](http://img.shields.io/travis/pavel-zlotarenchuk/iOSLogger.svg?style=flat)](https://travis-ci.org/pavel-zlotarenchuk/iOSLogger)
[![Version](https://img.shields.io/cocoapods/v/iOSLogger.svg?style=flat)](http://cocoapods.org/pods/iOSLogger)
[![License](https://img.shields.io/github/license/pavel-zlotarenchuk/iOSLogger.svg)](https://github.com/pavel-zlotarenchuk/iOSLogger/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/iOSLogger.svg?style=flat)](http://cocoapods.org/pods/iOSLogger)

A Swift 4.0 framework for logging your apps. Simple and quick to use.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS higher 10.3

## Installation

iOSLogger is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
    use_frameworks!
    pod 'iOSLogger', :git => 'https://github.com/pavel-zlotarenchuk/iOSLogger.git'
```
And run  `pod install`

## Usage

Import iOSLogger to the top of the Swift file.
```swift
    import iOSLogger
```
In AppDelegat use:
```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IOSLogger.appName = "NameYouApp"
        IOSLogger.authorEmail = "youemail@gmail.com"
        return true
    }
```
In the place where you want to record the log:
```swift
    IOSLogger.v() - for verbose
    IOSLogger.d() - for debug
    IOSLogger.i() - for info
    IOSLogger.w() - for warn
    IOSLogger.e() - for error
```
In the place where you want to read log from file:
```Swift
    IOSLogger.readLogs()
```
In the place where you want to send logs to the mail::
```Swift
    IOSLogger.sendLogs()
```

## Author

Pavel Zlotarenchuk (pavel.zlotarenchuk@gmail.com)

## License
```
    Copyright 2013 viktord1985, GreenMoby.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
```
