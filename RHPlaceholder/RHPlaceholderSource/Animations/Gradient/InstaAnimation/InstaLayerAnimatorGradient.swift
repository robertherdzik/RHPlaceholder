import UIKit

final class InstaLayerAnimatorGradient: LayerAnimating {
    // TODO [🌶]: duplication
    private struct Constants {
        static let basicAnimationKeyPath = "position.x"
        static let gradientAnimationAddKeyPath = "colorChange"
    }
    
    private let configuration: LayerAnimatorGradientConfigurable
    private let animation = CABasicAnimation(keyPath: Constants.basicAnimationKeyPath)
    private let gradient = CAGradientLayer()
    
    private lazy var gradientColors = [
        configuration.fromColor,
        configuration.toColor,
        configuration.toColor,
        configuration.fromColor
    ]
    private var currentGradient: Int = 0
    
    init(configuration: LayerAnimatorGradientConfigurable) {
        self.configuration = configuration
    }
    
    convenience required init() {
        self.init(configuration: InstaLayerAnimatorGradientConfiguration())
    }
    
    func addAnimation(to layer: CALayer) { // TODO [🌶]: extract using abstraction
        gradient.frame = CGRect(x: 0,
                                y: 0,
                                width: 2*layer.bounds.width,
                                height: 2*layer.bounds.height)

        gradient.startPoint = CGPoint(x:0.2, y:0.3)
        gradient.endPoint = CGPoint(x:1, y:1)
        gradient.locations = [0, 0.2, 0.22, 0.4]
        gradient.opacity = 0.4  // TODO [🌶]: move to the configuration
        gradient.colors = gradientColors
        
        layer.backgroundColor = configuration.fromColor.copy()
        layer.addSublayer(gradient)
        layer.masksToBounds = true
        
        animateGradient()
    }

    private func animateGradient() {
        animation.duration = configuration.animationDuration
        animation.fromValue = -gradient.bounds.width
        animation.toValue = gradient.bounds.width
        animation.repeatCount = Float.infinity
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animation.isRemovedOnCompletion = false
        
        gradient.add(animation, forKey: Constants.gradientAnimationAddKeyPath)
    }
}
