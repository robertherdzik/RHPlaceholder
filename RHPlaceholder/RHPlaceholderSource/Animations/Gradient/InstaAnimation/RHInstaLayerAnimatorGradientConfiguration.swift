import UIKit
 
struct RHInstaLayerAnimatorGradientConfiguration: RHLayerAnimatorGradientConfigurable {
    
    private(set) var animationDuration: CFTimeInterval = 0.5
    private(set) var fromColor: CGColor = UIColor.white.cgColor
    private(set) var toColor: CGColor = UIColor.lightGray.cgColor
}


