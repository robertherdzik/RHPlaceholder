
import UIKit

public final class Placeholder {
    
    private var placeholders = [PlaceholderItem]()
    private var layerAnimator: LayerAnimating.Type
    // Property keeps all references to the animators to avoid early release
    private var animators = [LayerAnimating]()
    
    /// Initializes and returns a newly allocated Placeholder object with the specified way of animation.
    ///
    /// - Parameter layerAnimator: the animator which contains specyfied layer animation logic,
    /// you can create your own Animators based on LayerAnimating protcol
    public init(layerAnimator: LayerAnimating.Type) {
        self.layerAnimator = layerAnimator
    }
    
    public convenience init() {
        self.init(layerAnimator: InstaLayerAnimatorGradient.self)
    }
    
    deinit {
        removeAnimatorsReferences()
    }
    
    /// Method register all elements which need Placeholder animation.
    /// Elements have to be registered each time when you invoke `remove()`.
    ///
    /// - Parameter viewElements: elements which should be nimated
    public func register(_ viewElements: [UIView]) {
        guard viewElements.count > 0 else { return }
        
        viewElements.forEach {
            let placeholderItem = PlaceholderItem(originItem: $0)
            self.placeholders.append(placeholderItem)
        }
    }
    
    /// Method trigger animation start on already registered elements
    /// *- NOTE: Method won't work, after invoking `remove()`, you need to register once again*
    /// *all elements to perform animation second time.*
    public func startAnimation() {
        addLayer()
        animate()
    }
    
    /// Method remove and stop all animation
    public func remove() {
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
