import UIKit
 // TODO [🌶]: duplication
public struct InstaLayerAnimatorGradientConfiguration: LayerAnimatorGradientConfigurable {
    
    public private(set) var animationDuration: CFTimeInterval = 2
    public private(set) var fromColor: CGColor = UIColor(rgb: 0xe6e6e6).cgColor
    public private(set) var toColor: CGColor = UIColor.white.cgColor
}


