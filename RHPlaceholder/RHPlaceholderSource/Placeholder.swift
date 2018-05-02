
import UIKit

final class Placeholder {
    
    private var placeholders = [PlaceholderItem]()
    private var layerAnimator: LayerAnimating.Type
    // Property keeps all references to the animators to avoid early release
    private var animators = [LayerAnimating]()
    
    init(layerAnimator: LayerAnimating.Type) {
        self.layerAnimator = layerAnimator
    }
    
    convenience init() {
        self.init(layerAnimator: InstaLayerAnimatorGradient.self)
    }
    
    deinit {
        removeAnimatorsReferences()
    }
    
    func register(_ viewElements: [UIView]) {
        guard viewElements.count > 0 else { return }
        
        viewElements.forEach {
            let placeholderItem = PlaceholderItem(originItem: $0)
            self.placeholders.append(placeholderItem)
        }
        
        addLayer()
    }
    
    func remove() {
        removeAnimatorsReferences()
    }
    
    func startAnimation() {
        animate()
    }
    
    func stopAnimation() {
        removeAnimation()
    }
    
    private func addLayer() {
        placeholders.forEach { placeholder in
            addShieldViewToOriginView(from: placeholder)
        }
    }
    
    private func addShieldViewToOriginView(from placeholder: PlaceholderItem) {
        let shield = placeholder.shield
        shield.backgroundColor = UIColor.white
        shield.autoresizingMask = [.flexibleBottomMargin, .flexibleRightMargin]
        
        shield.frame = placeholder.originItem.bounds
        placeholder.originItem.addSubview(shield)
        
        makeFadeInAnimation(forOriginItem: placeholder.originItem)
    }
    
    private func animate() {
        placeholders.forEach { [weak self] in
            let layer = $0.shield.layer
            let animator = self?.layerAnimator.init()
            animators.append(animator!)
            
            animator?.addAnimation(to: layer)
        }
    }
    
    private func removeAnimation() {
        placeholders.forEach {
            let layer = $0.shield.layer
            layer.removeAllAnimations()
        }
        
        animators.forEach() { item in
            item.removeGradientLayer()
        }
    }
    
    private func removeAnimatorsReferences() {
        removeAnimation()
        animators.removeAll()
    }
    
    // TODO [🌶]: Quick fix for 'jump in' showing of layers, should be better way to do this [Investigation needed]
    private func makeFadeInAnimation(forOriginItem originItem: UIView) {
        originItem.alpha = 0
        UIView.animate(withDuration: 3) {
            originItem.alpha = 1
        }
    }
}
