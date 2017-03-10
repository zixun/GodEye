# ANREye

[![Version](https://img.shields.io/cocoapods/v/Log4G.svg?style=flat)](http://cocoapods.org/pods/ANREye)
[![License](https://img.shields.io/cocoapods/l/Log4G.svg?style=flat)](http://cocoapods.org/pods/ANREye)
[![Platform](https://img.shields.io/cocoapods/p/Log4G.svg?style=flat)](http://cocoapods.org/pods/ANREye)

Class for monitor excessive blocking on the main thread

## Family
This library is derived from the [GodEye](https://github.com/zixun/GodEye) project which can automaticly display Log,Crash,Network,ANR,Leak,CPU,RAM,FPS,NetFlow,Folder and etc with one line of code. Just like god opened his eyes

## Book & Principle

**I has wrote a book named [《iOS监控编程》](https://www.qingdan.us/product/25),each chapter records the course function of the implementation details and the way to explore.sorry for english friends,this book wrote by chineses.**


## Installation

ANREye is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ANREye"
```

## Usage
### open and add delegate

```swift
self.anrEye = ANREye()
self.anrEye.delegate = self
self.anrEye.start(with: 1)
```

### implement the delegate

```swift
extension ViewController: ANREyeDelegate {
    
    func anrEye(anrEye:ANREye,
                catchWithThreshold threshold:Double,
                mainThreadBacktrace:String?,
                allThreadBacktrace:String?) {
        print("------------------")
        print(mainThreadBacktrace!)
        print("------------------")
        print(allThreadBacktrace!)
    }
}
```

### test code
```swift
var s = ""
for _ in 0..<9999 {
    for _ in 0..<9999 {
        s.append("1")
    }
}
    
print("invoke")
```

## Author

name: 陈奕龙

twitter: [@zixun_](https://twitter.com/zixun_)

email: chenyl.exe@gmail.com

github: [zixun](https://github.com/zixun)

blog: [子循(SubCycle)](http://zixun.github.io/)

## License

ANREye is available under the MIT license. See the LICENSE file for more info.
