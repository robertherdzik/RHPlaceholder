import UIKit
 // TODO [🌶]: duplication
public struct RainbowAnimatorGradientConfiguration: LayerAnimatorGradientConfigurable {
    
    public private(set) var animationDuration: CFTimeInterval = 0.9
    public private(set) var fromColor: CGColor = UIColor.green.cgColor
    public private(set) var toColor: CGColor = UIColor.orange.cgColor
}


