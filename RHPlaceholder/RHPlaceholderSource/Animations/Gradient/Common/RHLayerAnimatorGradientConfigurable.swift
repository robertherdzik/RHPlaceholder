import UIKit
// TODO [🌶]: move to common place in terms of gradients animations
protocol RHLayerAnimatorGradientConfigurable {
    var animationDuration: CFTimeInterval { get }
    var fromColor: CGColor { get }
    var toColor: CGColor { get }
}
