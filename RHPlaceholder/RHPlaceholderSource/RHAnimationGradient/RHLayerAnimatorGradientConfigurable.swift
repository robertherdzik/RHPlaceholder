import UIKit

protocol RHLayerAnimatorGradientConfigurable {
    var animationDuration: CFTimeInterval { get }
    var fromColor: CGColor { get }
    var toColor: CGColor { get }
}
