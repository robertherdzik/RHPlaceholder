import UIKit

public protocol BlinkAnimatorConfigurable {
    var animationDuration: CFTimeInterval { get }
    var blinkColor: CGColor { get }
}
