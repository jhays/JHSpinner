# JHSpinner

[![CI Status](http://img.shields.io/travis/JHays/JHSpinner.svg?style=flat)](https://travis-ci.org/JHays/JHSpinner)
[![Version](https://img.shields.io/cocoapods/v/JHSpinner.svg?style=flat)](http://cocoapods.org/pods/JHSpinner)
[![License](https://img.shields.io/cocoapods/l/JHSpinner.svg?style=flat)](http://cocoapods.org/pods/JHSpinner)
[![Platform](https://img.shields.io/cocoapods/p/JHSpinner.svg?style=flat)](http://cocoapods.org/pods/JHSpinner)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

To use JHSpinner, simply call the JHSpinnerView.showOnView(... function. 
There are a variety of optional parameters you can use to customize features such as the overlay type, colors, spinner animation speed, and text. 

Rounded Square:
```swift
let spinner = JHSpinnerView.showOnView(view, spinnerColor:UIColor.redColor(), overlay:.RoundedSquare, overlayColor:UIColor.blackColor().colorWithAlphaComponent(0.6))
        
view.addSubview(spinner)
```
![Screenshot](https://raw.githubusercontent.com/jhays/JHSpinner/master/RoundedSquare.gif)

Square:
```swift
let spinner = JHSpinnerView.showOnView(view, spinnerColor:UIColor.redColor(), overlay:.Square, overlayColor:UIColor.blackColor().colorWithAlphaComponent(0.6))
        
view.addSubview(spinner)
```
![Screenshot](https://raw.githubusercontent.com/jhays/JHSpinner/master/Square.gif)

Circular:
```swift
let spinner = JHSpinnerView.showOnView(view, spinnerColor:UIColor.redColor(), overlay:.Circular, overlayColor:UIColor.blackColor().colorWithAlphaComponent(0.6))
        
view.addSubview(spinner)
```
![Screenshot](https://raw.githubusercontent.com/jhays/JHSpinner/master/Circular.gif)

FullScreen:
```swift
let spinner = JHSpinnerView.showOnView(view, spinnerColor:UIColor.redColor(), overlay:.FullScreen, overlayColor:UIColor.blackColor().colorWithAlphaComponent(0.6))
        
view.addSubview(spinner)
```
![Screenshot](https://raw.githubusercontent.com/jhays/JHSpinner/master/FullScreen.gif)

Custom (the Custom enum value requires parameters to specify size and corner radius):
```swift
let spinner = JHSpinnerView.showOnView(view, spinnerColor:UIColor.redColor(), overlay:.Custom(CGSize(width: 300, height: 200), 20), overlayColor:UIColor.blackColor().colorWithAlphaComponent(0.6), fullCycleTime:4.0, text:"Loading")
        
view.addSubview(spinner)
```
![Screenshot](https://raw.githubusercontent.com/jhays/JHSpinner/master/Custom.gif)

Determinite (modify the spinner's progress property to update the circular loading indicator):
```swift
let spinner = JHSpinnerView.showDeterminiteSpinnerOnView(self.view)
spinner.progress = 0.0
view.addSubview(spinner)
```
![Screenshot](https://raw.githubusercontent.com/jhays/JHSpinner/master/Determinite.gif)

To remove a spinner:
```swift
spinner.dismiss()
```

## Requirements

iOS8+

## Installation

JHSpinner is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JHSpinner"
```

## Author

JHays, orbosphere@gmail.com

## License

JHSpinner is available under the MIT license. See the LICENSE file for more info.
