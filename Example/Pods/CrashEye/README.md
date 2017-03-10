#CrashEye

[![Version](https://img.shields.io/cocoapods/v/CrashEye.svg?style=flat)](http://cocoapods.org/pods/CrashEye)
[![License](https://img.shields.io/cocoapods/l/CrashEye.svg?style=flat)](http://cocoapods.org/pods/CrashEye)
[![Platform](https://img.shields.io/cocoapods/p/CrashEye.svg?style=flat)](http://cocoapods.org/pods/CrashEye)

CrashEye is an ios crash monitor，automatic catch exception crash & signal crash and return the stacktrace

## Family
This library is derived from the [GodEye](https://github.com/zixun/GodEye) project which can automaticly display Log,Crash,Network,ANR,Leak,CPU,RAM,FPS,NetFlow,Folder and etc with one line of code. Just like god opened his eyes

## Book & Principle

**I has wrote a book named [《iOS监控编程》](https://www.qingdan.us/product/25),each chapter records the course function of the implementation details and the way to explore.sorry for english friends,this book wrote by chineses.**

## Features

- [x] monitor uncatched exception crash.
- [x] monitor signal crash.


## Installation

CrashEye is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CrashEye"
```
## Usage
### open and add delegate

```swift
CrashEye.add(delegate: self)
CrashEye.open()
```

### implement the delegate

```swift
extension ViewController: CrashEyeDelegate {
    func crashEyeDidCatchCrash(with model:CrashModel) {
        print(model)
    }
}
```

## Author

name: 陈奕龙

twitter: [@zixun_](https://twitter.com/zixun_)

email: chenyl.exe@gmail.com

github: [zixun](https://github.com/zixun)

blog: [子循(SubCycle)](http://zixun.github.io/)



## License

CrashEye is available under the MIT license. See the LICENSE file for more info.
