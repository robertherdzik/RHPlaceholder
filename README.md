![](./ReadmeAssets/RHPlaceholder.png)

[![Version](https://img.shields.io/cocoapods/v/RHPlaceholder.svg?style=flat)](http://cocoadocs.org/docsets/RHPlaceholder)
[![License](https://img.shields.io/cocoapods/l/BadgeSwift.svg?style=flat)](/LICENSE)
[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)

# RHPlaceholder 💾
Because tradicional `loading view` like `UIActivityIndicatorView` or similar one are noo longer so trendy (Facebook or Instagram apps are moving away from this traditional approach in favour of loading way which is offered by this library), I decided to create very simple library which will give you oportunity to have it in your great project without big effort! 🍕 

## Play with it 😎
TBC
<p align="center">
<img src ="./ReadmeAssets/first_video.gif" width="360" height="250"/>
</p>

## Installation
You can install library using Cocoapods:
```
    pod 'RHPlaceholder'
```

## Usage
WOW... it is soo easy to use 🙊! Base integration with you storyboard VC will take couple minutes 💥

### Base Usage
just create instance const of `Placeholder`:
```swift
    private let placeholderMarker = Placeholder()
```
in your `ViewController` 

... and then just bind up library with views which needs to be animated:

```swift
    private func addPlaceholder() {
        let viewElements: [UIView] = [
            name,
            surname,
            age,
            email,
            birthDate
        ]
        
        placeholderMarker.register(viewElements)
    }
```
call `addPlaceholder()` method in `viewDidLoad()`. 
Boom 😲 library has been associated with your views 👏

all what left is to controll showing 'loading' animation on your views using `startAnimation()` and `remove()`
```swift
    func fetchUserData() {
        placeholderMarker.startAnimation()
        apiManager.fetchUser() { [weak self] user in 
            self?.placeholderMarker.remove()
            // .. rest of the method
        }
    }
```

### Advanced Configuration
TBC

### Create your own animation! 🙊
TBC

## Swift support
| Library ver| Swift ver|
| ------------- |:-------------:|
| 0.0.1   | 4.1 |

## Check the Demo project

Please check out the demo project, you can see there how Library has been implemented in details.

---
## TODO:
- URGENT
- [x] add API methods for `showLoading()` and `hideLoading()`
- [x] add shimmering animation
- [ ] create pod
- [x] add color configuration
- [ ] add TableView example
- [ ] fix delay related with adding layers in viewDidLoad 
- [ ] fix tabbar on iPhone 8 in the example app
- [ ] write documentation
- [ ] try to improve performance

- OPTIONAL
- [ ] extract gradient animations logic
- [ ] add posibility to set bg image below animated gradient
- [ ] improve InstaLayerAnimatorGradient, gradient should respect the size of layer in which he is displayed

 
