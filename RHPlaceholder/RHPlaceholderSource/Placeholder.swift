
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
        self.init(layerAnimator: RHInstaLayerAnimatorGradient.self)
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
        placeholders.forEach { placeholder in
            let layer = placeholder.shield
            layer.removeFromSuperview()
        }
        
        removeAnimatorsReferences()
    }
    
    private func addLayer() {
        placeholders.forEach { placeholder in
            addShieldViewToOriginView(from: placeholder)
        }
        
        animate()
    }
    
    private func addShieldViewToOriginView(from placeholder: PlaceholderItem) {
        let shield = placeholder.shield
        shield.backgroundColor = UIColor.white
        shield.autoresizingMask = [.flexibleBottomMargin, .flexibleRightMargin]
        
        shield.frame = placeholder.originItem.bounds
        placeholder.originItem.addSubview(shield)
    }
    
    private func animate() {
        placeholders.forEach { [weak self] in
            let layer = $0.shield.layer
            let animator = self?.layerAnimator.init()
            animators.append(animator!)
            
            animator?.addAnimation(to: layer)
        }
    }
    
    private func removeAnimatorsReferences() {
        animators.removeAll()
    }
    
    deinit {
        removeAnimatorsReferences()
    }
}
