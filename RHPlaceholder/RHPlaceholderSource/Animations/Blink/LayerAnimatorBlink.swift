import UIKit

struct LayerAnimatorBlink: LayerAnimating {
    
    private struct Constants {
        static let basicAnimationKeyPath = "backgroundColor"
        static let gradientAnimationAddKeyPath = "colorChange"
    }
    
    private let configuration: LayerAnimatorBlinkConfigurable
    
    init(configuration: LayerAnimatorBlinkConfigurable) {
        self.configuration = configuration
    }
    
    init() {
        self.init(configuration: LayerAnimatorBlinkConfiguration())
    }
    
    func addAnimation(to layer: CALayer) {
        let animation = CABasicAnimation(keyPath: Constants.basicAnimationKeyPath)
        animation.duration = configuration.animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.toValue = configuration.blinkColor
        
        layer.add(animation, forKey: Constants.gradientAnimationAddKeyPath)
    }
}
