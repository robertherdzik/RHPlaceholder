import UIKit
 // TODO [🌶]: duplication
struct RainbowAnimatorGradientConfiguration: LayerAnimatorGradientConfigurable {
    
    private(set) var animationDuration: CFTimeInterval = 0.9
    private(set) var fromColor: CGColor = UIColor.green.cgColor
    private(set) var toColor: CGColor = UIColor.orange.cgColor
}


