import UIKit
// TODO [🌶]: move to common place in terms of gradients animations
protocol LayerAnimatorGradientConfigurable {
    var animationDuration: CFTimeInterval { get }
    var fromColor: CGColor { get }
    var toColor: CGColor { get }
}
