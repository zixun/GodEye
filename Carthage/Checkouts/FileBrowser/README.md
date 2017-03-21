![FileBrowser - iOS Finder-style file browser in Swift](https://cloud.githubusercontent.com/assets/889949/13035402/75e4eb00-d34f-11e5-8b92-c921ecca9300.png)

[![Build Status](https://travis-ci.org/marmelroy/FileBrowser.svg?branch=master)](https://travis-ci.org/marmelroy/FileBrowser) [![Version](http://img.shields.io/cocoapods/v/FileBrowser.svg)](http://cocoapods.org/?q=FileBrowser)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# FileBrowser
iOS Finder-style file browser in Swift with search, file previews and 3D touch. Simple and quick to use.

<p align="center"><img src="http://i.giphy.com/3o6gaY6yLQkhjiok5W.gif" width="242" height="425"/></p>

## Features


              |  Features
--------------------------|------------------------------------------------------------
:iphone: | Browse and select files and folders with a familiar UI on iOS.
:mag: | Pull down to search.
:eyeglasses: | Preview most file types. Including plist and json.
:point_up_2: | 3D touch support for faster previews with Peek & Pop.
:white_flower: | Fully customizable.


## Usage

Import FileBrowser at the top of the Swift file.

```swift
import FileBrowser
```

To show the file browser, all you need to do is:
```swift
let fileBrowser = FileBrowser()
present(file, animated: true, completion: nil)
```

By default, the file browser will open in your app's documents directory. When users select a file, a preview will be displayed - offering an action sheet of options based on the file type.

## Advanced Usage

You can open FileBrowser in a different root folder by initialising with an NSURL file path of your choice.
```swift
let fileBrowser = FileBrowser(initialPath: customPath)
```

Use the didSelectFile closure to change FileBrowser's behaviour when a file is selected.
```swift
fileBrowser.didSelectFile = { (file: FBFile) -> Void in
    print(file.displayName)
}
```

To exclude a certain file type or a specific file path:
```swift
fileBrowser.excludesFileExtensions = ["zip"]
fileBrowser.excludesFilepaths = [secretFile]
```

### Setting up with [CocoaPods](http://cocoapods.org/?q=FileBrowser)
```ruby
source 'https://github.com/CocoaPods/Specs.git'
pod 'FileBrowser', '~> 0.2'
```

### Setting up with Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate FileBrowser into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "marmelroy/FileBrowser"
```
