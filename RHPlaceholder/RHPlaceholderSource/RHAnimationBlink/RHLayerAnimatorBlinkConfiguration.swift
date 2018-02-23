import UIKit

struct RHLayerAnimatorBlinkConfiguration: RHLayerAnimatorBlinkConfigurable {
    
    private(set) var animationDuration: CFTimeInterval = 0.6
    private(set) var blinkColor: CGColor = UIColor.lightGray.cgColor
}
