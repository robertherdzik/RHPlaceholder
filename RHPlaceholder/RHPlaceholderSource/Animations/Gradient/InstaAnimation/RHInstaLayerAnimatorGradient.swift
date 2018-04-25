import UIKit

final class RHInstaLayerAnimatorGradient: LayerAnimating {
    // TODO [🌶]: duplication
    private struct Constants {
        static let basicAnimationKeyPath = "colors"
        static let gradientAnimationAddKeyPath = "colorChange"
    }
    
    private let configuration: RHLayerAnimatorGradientConfigurable
    private let animation = CABasicAnimation(keyPath: Constants.basicAnimationKeyPath)
    private let gradient = CAGradientLayer()
    
    private lazy var gradientColors = [
        [configuration.fromColor, configuration.toColor],
        [configuration.toColor, configuration.fromColor]
    ]
    private var currentGradient: Int = 0
    private var animationDelegate: RHCAAnimationDelegateReceiver?
    
    init(configuration: RHLayerAnimatorGradientConfigurable) {
        self.configuration = configuration
        
        setupAnimationDelegateReceiver()
    }
    
    convenience required init() {
        self.init(configuration: RHInstaLayerAnimatorGradientConfiguration())
    }
    
    func addAnimation(to layer: CALayer) { // TODO [🌶]: extract using abstraction
        gradient.frame = layer.bounds
        gradient.startPoint = CGPoint(x:0.1, y:0) // TODO [🌶]: adjust gradient according to element size
        gradient.endPoint = CGPoint(x:0.8, y:0.2)
        gradient.opacity = 0.2 // TODO [🌶]: move to the configuration
        
        layer.addSublayer(gradient)
        
        animateGradient()
    }
    
    private func animateGradient() {
        adjustCurrentGradientNumber()
        
        animation.duration = configuration.animationDuration
        animation.toValue = gradientColors[currentGradient]
        animation.fillMode = kCAFillModeBoth
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
        animationDelegate = RHCAAnimationDelegateReceiver(animationDidStopCompletion: { [weak self] in
            guard let sSelf = self else { return }
            
            sSelf.gradient.colors = sSelf.gradientColors[sSelf.currentGradient]
            sSelf.animateGradient()
        })
        animation.delegate = animationDelegate
    }
}
