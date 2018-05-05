![](./ReadmeAssets/RHPlaceholder.png)

[![Version](https://img.shields.io/cocoapods/v/RHPlaceholder.svg?style=flat)](http://cocoadocs.org/docsets/RHPlaceholder)
[![License](https://img.shields.io/cocoapods/l/BadgeSwift.svg?style=flat)](/LICENSE)
[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)

# RHPlaceholder 💾
Because tradicional `loading view` like `UIActivityIndicatorView` or similar one are noo longer so trendy (Facebook or Instagram apps are moving away from these approaches), I decided to create very simple library which will give you oportunity to have Facebook or Instagram 'view loading state' in your great project without big effort 💥! 🍕 

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
just create instance const of `Placeholder` in your `ViewController`:
```swift
private let placeholderMarker = Placeholder() // By default you will have Insta like gradient animation
```

but of course you can choose between rest of predefined animations:
```swift
private let placeholderMarker = Placeholder(layerAnimator: RainbowAnimatorGradient.self)
```

Available animations: 
- `InstaLayerAnimatorGradient` (`Paceholder` designated init default value)
TBC (add animation)
- `RainbowAnimatorGradient`
TBC (add animation)
- `BackAndFortLayerAnimatorGradient`
TBC (add animation)
- `BlinkAnimator`
TBC (add animation)


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

### Layout Inspiration
Layout inspiration has been taken from one of the Dribbble projects, unfortunately I cannot find now this project anymore, because of that I cannot annotate creator in here 😦...

---
## TODO:
- URGENT
- [x] add API methods for `showLoading()` and `hideLoading()`
- [x] add shimmering animation
- [ ] create pod
- [x] add color configuration
- [ ] add TableView example
- [x] fix delay related with adding layers in viewDidLoad 
- [x] fix tabbar on iPhone 8 in the example app
- [ ] write documentation
- [x] improve performance
- [ ] add icons for tabbar items

- OPTIONAL
- [ ] extract gradient animations logic
- [ ] add posibility to set bg image below animated gradient
- [ ] improve InstaLayerAnimatorGradient, gradient should respect the size of layer in which he is displayed

 
