import UIKit
// TODO [🌶]: move to common place in terms of gradients animations
public protocol LayerAnimatorGradientConfigurable {
    var animationDuration: CFTimeInterval { get }
    var fromColor: CGColor { get }
    var toColor: CGColor { get }
}
