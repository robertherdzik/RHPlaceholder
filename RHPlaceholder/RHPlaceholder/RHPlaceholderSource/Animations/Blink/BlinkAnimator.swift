import UIKit

public struct BlinkAnimator: LayerAnimating {
    
    public let originLayerColor: CGColor
    
    private struct Constants {
        static let basicAnimationKeyPath = "backgroundColor"
        static let gradientAnimationAddKeyPath = "colorChange"
    }
    
    private let configuration: BlinkAnimatorConfigurable
    
    init(configuration: BlinkAnimatorConfigurable) {
        self.configuration = configuration
        originLayerColor = UIColor.white.cgColor
    }
    
    public init() {
        self.init(configuration: BlinkAnimatorConfiguration())
    }
    
    public func getAnimatedLayer(withReferenceFrame frame: CGRect) -> CALayer {
        let animation = CABasicAnimation(keyPath: Constants.basicAnimationKeyPath)
        animation.duration = configuration.animationDuration
        animation.repeatCount = Float.infinity
        animation.toValue = configuration.blinkColor
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let layer = UIView(frame: frame).layer
        layer.add(animation, forKey: Constants.gradientAnimationAddKeyPath)
        
        return layer
    }
}
