# Log4G

[![CI Status](http://img.shields.io/travis/zixun/Log4G.svg?style=flat)](https://travis-ci.org/zixun/Log4G)
[![Version](https://img.shields.io/cocoapods/v/Log4G.svg?style=flat)](http://cocoapods.org/pods/Log4G)
[![License](https://img.shields.io/cocoapods/l/Log4G.svg?style=flat)](http://cocoapods.org/pods/Log4G)
[![Platform](https://img.shields.io/cocoapods/p/Log4G.svg?style=flat)](http://cocoapods.org/pods/Log4G)

Simple, lightweight logging framework written in Swift

## Features

- [x] Log type support: `log`,`warning`,`error`.
- [x] Automaticly get log‘s file, line, function and thread.
- [x] Allow multiple delegate listeners to monitor log behavior.


## Installation

Log4G is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Log4G"
```

## Usage
### Log a log type message

```swift
Log4G.log("message")
```

### Log a warning type message

```swift
Log4G.warning("message")
```

### Log an error type message

```swift
Log4G.error("message")
```

### Add to the log delegate listener

```swift
Log4G.add(delegate: self)
```

And implement delegate of `Log4GDelegate`:

```swift
func log4gDidRecord(with model:LogModel) {
    //Some Monitor Action
}
```

### Remove frome the log delegate listener
```swift
Log4G.remove(delegate: self)
```

## Author

name: 陈奕龙

twitter: [@zixun_](https://twitter.com/zixun_)

email: chenyl.exe@gmail.com

github: [zixun](https://github.com/zixun)

blog: [子循(SubCycle)](http://zixun.github.io/)



## License

Log4G is available under the MIT license. See the LICENSE file for more info.
