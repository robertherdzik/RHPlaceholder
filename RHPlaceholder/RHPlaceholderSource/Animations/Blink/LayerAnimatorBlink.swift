import UIKit

struct LayerAnimatorBlink: LayerAnimating {
    
    let originLayerColor: CGColor
    
    private struct Constants {
        static let basicAnimationKeyPath = "backgroundColor"
        static let gradientAnimationAddKeyPath = "colorChange"
    }
    
    private let configuration: LayerAnimatorBlinkConfigurable
    
    init(configuration: LayerAnimatorBlinkConfigurable) {
        self.configuration = configuration
        originLayerColor = UIColor.white.cgColor
    }
    
    init() {
        self.init(configuration: LayerAnimatorBlinkConfiguration())
    }
    
    func getAnimatedLayer(withReferenceFrame frame: CGRect) -> CALayer {
        let animation = CABasicAnimation(keyPath: Constants.basicAnimationKeyPath)
        animation.duration = configuration.animationDuration
        animation.repeatCount = Float.infinity
        animation.toValue = configuration.blinkColor
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let layer = UIView(frame: frame).layer
        layer.add(animation, forKey: Constants.gradientAnimationAddKeyPath)
        
        return layer
    }
}
