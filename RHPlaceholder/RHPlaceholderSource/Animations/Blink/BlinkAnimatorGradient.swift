import UIKit

struct BlinkAnimatorGradient: LayerAnimating {
    
    let originLayerColor: CGColor
    
    private struct Constants {
        static let basicAnimationKeyPath = "backgroundColor"
        static let gradientAnimationAddKeyPath = "colorChange"
    }
    
    private let configuration: BlinkAnimatorGradientConfigurable
    
    init(configuration: BlinkAnimatorGradientConfigurable) {
        self.configuration = configuration
        originLayerColor = UIColor.white.cgColor
    }
    
    init() {
        self.init(configuration: BlinkAnimatorGradientConfiguration())
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
