import UIKit

final class InstaLayerAnimatorGradient: LayerAnimating {
   
    var originLayerColor: CGColor
    
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
        originLayerColor = configuration.fromColor
    }
    
    convenience required init() {
        self.init(configuration: InstaLayerAnimatorGradientConfiguration())
    }
    
    func getAnimatedLayer(withReferenceFrame frame: CGRect) -> CALayer { // TODO [🌶]: extract using abstraction
        gradient.frame = CGRect(x: 0,
                                y: 0,
                                width: 2*frame.width,
                                height: 2*frame.height)

        gradient.startPoint = CGPoint(x:0.2, y:0.3)
        gradient.endPoint = CGPoint(x:1, y:0.6)
        gradient.locations = [0, 0.2, 0.22, 0.4]
        gradient.opacity = 0.4  // TODO [🌶]: move to the configuration
        gradient.colors = gradientColors
        
        animateGradient()
        
        return gradient
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
