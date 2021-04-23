# NetworkEye

[![License](https://img.shields.io/cocoapods/l/NetworkEye.svg?style=flat)](http://cocoapods.org/pods/NetworkEye)
[![Platform](https://img.shields.io/cocoapods/p/NetworkEye.svg?style=flat)](http://cocoapods.org/pods/NetworkEye)
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage) 

NetworkEye is a network monitor,automatic catch the request and response information of all kinds of request send

## Family
This library is derived from the [GodEye](https://github.com/zixun/GodEye) project which can automatically display Log,Crash,Network,ANR,Leak,CPU,RAM,FPS,NetFlow,Folder and etc with one line of code. Just like god opened his eyes

## Book & Principle

**I has wrote a book named [《iOS监控编程》](https://www.qingdan.us/product/25),each chapter records the course function of the implementation details and the way to explore.sorry for english friends,this book wrote by chineses.**

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

add observer:

```swift
NetworkEye.add(observer: self)
```
implement the observer delegate:

```swift
func networkEyeDidCatch(with request:URLRequest?,response:URLResponse?,data:Data?) {
    XCTAssert(true, "Pass")
}
```



## Installation

### CocoaPods
NetworkEye is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "NetworkEye"
```
### Carthage
Or, if you’re using [Carthage](https://github.com/Carthage/Carthage), add NetworkEye to your Cartfile:

``` 
github "zixun/NetworkEye"
```

## Author

name: 陈奕龙

twitter: [@zixun_](https://twitter.com/zixun_)

email: chenyl.exe@gmail.com

github: [zixun](https://github.com/zixun)

blog: [子循(SubCycle)](http://zixun.github.io/)

## License

NetworkEye is available under the MIT license. See the LICENSE file for more info.
