import UIKit
 
public struct BackAndForthLayerAnimatorGradientConfiguration: LayerAnimatorGradientConfigurable {
    
    public private(set) var animationDuration: CFTimeInterval = 0.5
    public private(set) var fromColor: CGColor = UIColor.white.cgColor
    public private(set) var toColor: CGColor = UIColor.lightGray.cgColor
}


