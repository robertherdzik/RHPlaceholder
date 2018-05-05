
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
        self.init(layerAnimator: RainbowAnimatorGradient.self)
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
    }
    
    func startAnimation() {
        addLayer()
        animate()
    }
    
    func remove() {
        removeAnimation()
        removeAnimatorsReferences()
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

//        makeFadeInAnimation(forOriginItem: placeholder.originItem)
    }
    
    private func animate() {
        let referenceFrame = CGRect(origin: CGPoint.zero,
                                    size: getFinalGradientSize())
        
        _ = placeholders.map { [weak self] in
            let layer = $0.shield.layer
            let animator = self?.layerAnimator.init()
            animators.append(animator!)
            
            if let animatedLayer = animator?.getAnimatedLayer(withReferenceFrame: referenceFrame) {
                layer.cornerRadius = 5 // TODO [🌶]: oportunity to customize `cornerRadius`
                layer.backgroundColor = animator?.originLayerColor
                layer.addSublayer(animatedLayer)
                layer.masksToBounds = true
            }
        }
    }
    
    private func removeAnimation() {
        _ = placeholders.map {
            $0.shield.removeFromSuperview()
        }
    }
    
    private func removeAnimatorsReferences() {
        removeAnimation()
        animators.removeAll()
        placeholders.removeAll()
    }
    
    private func getFinalGradientSize() -> CGSize {
        let gratestWidth = getGratestWidth()
        let gratestHeigth = getGratestHeight()
        
        return CGSize(width: gratestWidth,
                      height: gratestHeigth)
    }
    
    private func getGratestWidth() -> CGFloat {
        return placeholders.sorted { first, second -> Bool in
            first.originItem.bounds.width > second.originItem.bounds.width
            }.first?.shield.bounds.width ?? 0
    }
    
    private func getGratestHeight() -> CGFloat {
        return placeholders.sorted { first, second -> Bool in
            first.originItem.bounds.height > second.originItem.bounds.height
            }.first?.shield.bounds.height ?? 0
    }
//    // TODO [🌶]: Quick fix for 'jump in' showing of layers, should be better way to do this [Investigation needed]
//    private func makeFadeInAnimation(forOriginItem originItem: UIView) {
//        originItem.alpha = 0
//        UIView.animate(withDuration: 3) {
//            originItem.alpha = 1
//        }
//    }
}
