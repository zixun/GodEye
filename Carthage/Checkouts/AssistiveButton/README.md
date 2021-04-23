# AssistiveButton

[![Swift 3.0+](https://img.shields.io/badge/Swift-3.0%2B-orange.svg)](https://github.com/zixun/AssistiveButton)
[![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)](https://github.com/zixun/AssistiveButton)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage) 
## Context
This library is derived from the [GodEye](https://github.com/zixun/GodEye) project which can automatically disply Log,Crash,Network,ANR,Leak,CPU,RAM,FPS,NetFlow,Folder and etc with one line of code. Just like god opened his eyes

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

### CocoaPods
AssistiveButton is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AssistiveButton"
```

### Carthage
Or, if you’re using [Carthage](https://github.com/Carthage/Carthage), add SwViewCapture to your Cartfile:

``` 
github "zixun/AssistiveButton"
```

## Usage

```swift
let frame = CGRect(x: 0, y: 100, width: 48, height: 48)
let btn = AssistiveButton(frame: frame, normalImage: UIImage(named: "test")!)
    
btn.didTap = { () -> () in
    print("abc")
}
self.view.addSubview(btn)
```

## Author

name: 陈奕龙

twitter: [@zixun_](https://twitter.com/zixun_)

email: chenyl.exe@gmail.com

github: [zixun](https://github.com/zixun)

blog: [子循(SubCycle)](http://zixun.github.io/)

## License

AssistiveButton is available under the MIT license. See the LICENSE file for more info.
