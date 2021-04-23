# ASLEye

[![Version](https://img.shields.io/cocoapods/v/Log4G.svg?style=flat)](http://cocoapods.org/pods/ASLEye)
[![License](https://img.shields.io/cocoapods/l/Log4G.svg?style=flat)](http://cocoapods.org/pods/ASLEye)
[![Platform](https://img.shields.io/cocoapods/p/Log4G.svg?style=flat)](http://cocoapods.org/pods/ASLEye)

[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage) 


ASLEye is an ASL(Apple System Log) monitor, automatic catch the log from NSLog by asl module

## Family
This library is derived from the [GodEye](https://github.com/zixun/GodEye) project which can automatically display Log,Crash,Network,ANR,Leak,CPU,RAM,FPS,NetFlow,Folder and etc with one line of code. Just like god opened his eyes

## Book & Principle

**I has wrote a book named [《iOS监控编程》](https://www.qingdan.us/product/25),each chapter records the course function of the implementation details and the way to explore.sorry for english friends,this book wrote by chineses.**

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

1.init the asl eye:

```swift
self.aslEye = ASLEye()
self.aslEye.delegate = self
self.aslEye.open(with: 2)
```

2.implement the `ASLEyeDelegate` delegate:

```swift
func aslEye(aslEye:ASLEye,catchLogs logs:[String]) {
    print(logs)
}
```

## Installation

### CocoaPods
ASLEye is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ASLEye"
```

### Carthage
Or, if you’re using [Carthage](https://github.com/Carthage/Carthage), add SwViewCapture to your Cartfile:

``` 
github "zixun/ASLEye"
```

## Author

name: 陈奕龙

twitter: [@zixun_](https://twitter.com/zixun_)

email: chenyl.exe@gmail.com

github: [zixun](https://github.com/zixun)

blog: [子循(SubCycle)](http://zixun.github.io/)

## License

ASLEye is available under the MIT license. See the LICENSE file for more info.
