import UIKit

struct BlinkAnimatorConfiguration: BlinkAnimatorConfigurable {
    
    private(set) var animationDuration: CFTimeInterval = 1
    private(set) var blinkColor: CGColor = UIColor(rgb: 0xe6e6e6).cgColor
}
