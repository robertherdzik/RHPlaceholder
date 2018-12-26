import UIKit
// TODO [🌶]:  implement rainbow
final class RainbowAnimatorGradient: LayerAnimating {
    
    var originLayerColor: CGColor
    
    // TODO [🌶]: duplication
    private struct Constants {
        static let basicAnimationKeyPath = "colors"
        static let gradientAnimationAddKeyPath = "colorChange"
    }
    
    private let configuration: LayerAnimatorGradientConfigurable
    private let animation = CABasicAnimation(keyPath: Constants.basicAnimationKeyPath)
    private let gradient = CAGradientLayer()
    private let gradientColors: [[CGColor]]
    
    private var currentGradient: Int = 0
    private var animationDelegate: CAAnimationDelegateReceiver?
    
    init(configuration: LayerAnimatorGradientConfigurable) {
        self.configuration = configuration
        
        gradientColors = [
            [configuration.fromColor,
             UIColor(rgb: 0x3333ff).withAlphaComponent(0.5).cgColor,
             UIColor.magenta.cgColor,
             UIColor.purple.cgColor,
             UIColor.cyan.cgColor,
             configuration.toColor],
            
            [UIColor.red.cgColor,
             UIColor(rgb: 0xffff00).cgColor,
             configuration.toColor,
             UIColor.cyan.cgColor,
             UIColor.magenta.cgColor,
             configuration.fromColor]
        ]
        originLayerColor = UIColor.white.cgColor
        setupAnimationDelegateReceiver()
    }
    
    convenience required init() {
        self.init(configuration: RainbowAnimatorGradientConfiguration())
    }
    
    func getAnimatedLayer(withReferenceFrame frame: CGRect) -> CALayer {
        gradient.frame = frame
        gradient.startPoint = CGPoint(x:0.1, y:0) // TODO [🌶]: adjust gradient according to element size
        gradient.endPoint = CGPoint(x:0.8, y:0.2)
        gradient.locations = [0, 0.2, 0.4, 0.6, 0.8, 1]
        gradient.opacity = 0.4 // TODO [🌶]: move to the configuration
        
        animateGradient()
        
        return gradient
    }
    
    private func animateGradient() {
        adjustCurrentGradientNumber()
        
        animation.duration = configuration.animationDuration
        animation.toValue = gradientColors[currentGradient]
        animation.fillMode = CAMediaTimingFillMode.both
        animation.isRemovedOnCompletion = false
        
        gradient.add(animation, forKey: Constants.gradientAnimationAddKeyPath)
    }
    
    private func adjustCurrentGradientNumber() {
        let isGradientNumberExceedGradientColors = currentGradient >= gradientColors.count - 1
        if isGradientNumberExceedGradientColors {
            currentGradient = 0
        } else {
            currentGradient += 1
        }
    }
    
    private func setupAnimationDelegateReceiver() {
        animationDelegate = CAAnimationDelegateReceiver(animationDidStopCompletion: { [weak self] in
            guard let sSelf = self else { return }
            
            sSelf.gradient.colors = sSelf.gradientColors[sSelf.currentGradient]
            sSelf.animateGradient()
        })
        animation.delegate = animationDelegate
    }
}

