# DSDeviceKit

[![CI Status](http://img.shields.io/travis/Dmitry Sokolov/DSDeviceKit.svg?style=flat)](https://travis-ci.org/Dmitry Sokolov/DSDeviceKit)
[![Version](https://img.shields.io/cocoapods/v/DSDeviceKit.svg?style=flat)](http://cocoapods.org/pods/DSDeviceKit)
[![License](https://img.shields.io/cocoapods/l/DSDeviceKit.svg?style=flat)](http://cocoapods.org/pods/DSDeviceKit)
[![Platform](https://img.shields.io/cocoapods/p/DSDeviceKit.svg?style=flat)](http://cocoapods.org/pods/DSDeviceKit)



![](DSDeviceKit.png?raw=true "DSDeviceKit screenshot")


## Overview

A wrapper for UIDevice that provides quick access to all necessary information about current Device. Implements the Singleton Pattern

## Requirements

* ARC
* iOS 8 (dynamic framework)

## Installation

DSDeviceKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DSDeviceKit"
```

## Usage

```Swift
import DSDeviceKit

let device = DSDeviceKit.currentDevice

print(device.modelName)     // "iPhone 6s" or "iPad Air 2" and so on
print(device.identifier)    // "iPhone8,1" or "Simulator" and so on
print(device.iOSVersion)    // "9.3" and so on
print(device.deviceType)    // "iPhone" or "iPad" or "iPod Touch" or "Unknown"
print(device.isPhone)       // true or false

let devices = ["iphone 6", "ipad pro", "iPhone SE"]


if device.isOneOf(devices) {
    // is one of the allowed devices
}

```

## Example project

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Author

Dmitry Sokolov

## License

DSDeviceKit is available under the MIT license. See the LICENSE file for more info.
