# AppSwizzle

[![Swift 3.0+](https://img.shields.io/badge/Swift-3.0%2B-orange.svg)](https://github.com/zixun/AppBaseKit)
[![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)](https://github.com/zixun/AppBaseKit)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

AppSwizzle is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AppSwizzle"
```
## Usage

### Swizzle Instance Method

```swift
let orig = #selector(AppSwizzleTests.origSelector_testSwizzleInstanceMethod)
let alter = #selector(AppSwizzleTests.alterSelector_testSwizzleInstanceMethod)
AppSwizzleTests.swizzleInstanceMethod(origSelector: orig, toAlterSelector: alter)
```

### Swizzle Class Method

```swift
let orig = #selector(AppSwizzleTests.origSelector_testSwizzleClassMethod)
let alter = #selector(AppSwizzleTests.alterSelector_testSwizzleClassMethod)
AppSwizzleTests.swizzleClassMethod(origSelector: orig, toAlterSelector: alter)
```

### Swizzle Instance Method To Alter Class

```swift
let orig = #selector(AppSwizzleTests.origSelector_testSwizzleInstanceMethodToAlterClass)
let alter = #selector(OtherClass.alterSelector_testSwizzleInstanceMethodToAlterClass)
AppSwizzleTests.swizzleInstanceMethod(origSelector: orig, toAlterSelector: alter, inAlterClass: OtherClass.classForCoder())
```

### Swizzle Class Method To Alter Class

```swift
let orig = #selector(AppSwizzleTests.origSelector_testSwizzleClassMethodToAlterClass)
let alter = #selector(OtherClass.alterSelector_testSwizzleClassMethodToAlterClass)
AppSwizzleTests.swizzleClassMethod(origSelector: orig, toAlterSelector: alter, inAlterClass: OtherClass.classForCoder())
```

## Author

name: 陈奕龙

twitter: [@zixun_](https://twitter.com/zixun_)

email: chenyl.exe@gmail.com

github: [zixun](https://github.com/zixun)

blog: [子循(SubCycle)](http://zixun.github.io/)

## License

AppSwizzle is available under the MIT license. See the LICENSE file for more info.
