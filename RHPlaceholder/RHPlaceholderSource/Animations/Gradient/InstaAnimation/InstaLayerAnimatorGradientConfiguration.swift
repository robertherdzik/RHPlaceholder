import UIKit
 // TODO [🌶]: duplication
struct InstaLayerAnimatorGradientConfiguration: LayerAnimatorGradientConfigurable {
    
    private(set) var animationDuration: CFTimeInterval = 2
    private(set) var fromColor: CGColor = UIColor(rgb: 0xbfbfbf).cgColor
    private(set) var toColor: CGColor = UIColor.white.cgColor
}


