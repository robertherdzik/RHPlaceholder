import UIKit
 // TODO [🌶]: duplication
struct InstaLayerAnimatorGradientConfiguration: LayerAnimatorGradientConfigurable {
    
    private(set) var animationDuration: CFTimeInterval = 1
    private(set) var fromColor: CGColor = UIColor(rgb: 0xe6e6e6).cgColor
    private(set) var toColor: CGColor = UIColor.white.cgColor
}


