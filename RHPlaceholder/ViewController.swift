
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var photoView1: UIView!
    @IBOutlet weak var photoView2: UIView!
    @IBOutlet weak var photoView3: UIView!
    @IBOutlet weak var photoImgView4: UIView!
   
    @IBOutlet weak var numberOfMiles: UILabel!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var age: UILabel!
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var birthDate: UILabel!
    @IBOutlet weak var sex: UILabel!
    
    private let placeholderMarker = RHPlaceholder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundProfileImageContainers()
        
        // Adding placeholder 
        addPlaceholder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Fetched data from API simulation
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.removePhaceholder()
        }
    }
    
    private func addPlaceholder() {
        let viewElements: [UIView] = [photoImgView4,
                                      numberOfMiles,
                                      name,
                                      surname,
                                      age,
                                      email,
                                      birthDate,
                                      sex]
        placeholderMarker.register(viewElements)
    }

    @objc private func removePhaceholder() {
        placeholderMarker.remove()
    }
    
    private func roundProfileImageContainers() {
        [photoView1, photoView2, photoView3, photoImgView4].forEach {
            $0.layer.cornerRadius = $0.bounds.width/2
        }
        photoImgView4.layer.masksToBounds = true
    }
}

final class RHPlaceholder {
    
    private var placeholders = [RHPlaceholderItem]()
    private var layerAnimator: RHLayerAnimating.Type
    // Property keeps all references to the animators to avoid early release
    private var animators = [RHLayerAnimating]()
    
    init(layerAnimator: RHLayerAnimating.Type) {
        self.layerAnimator = layerAnimator
    }
    
    convenience init() {
        self.init(layerAnimator: RHLayerAnimatorGradient.self)
    }
    
    func register(_ viewElements: [UIView]) {
        viewElements.forEach {
            let placeholderItem = RHPlaceholderItem(originItem: $0)
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
            addShieldViewOriginView(from: placeholder)
        }
        
        animate()
    }
    
    private func addShieldViewOriginView(from placeholder: RHPlaceholderItem) {
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

struct RHPlaceholderItem {
    
    let originItem: UIView // TODO [🌶]: consider 'weak'
    let shield = UIView()
    
    init(originItem: UIView) {
        self.originItem = originItem
    }
}

// ------------------------------------------------
// ------------------------------------------------
protocol RHLayerAnimatorGradientConfigurable {
    var animationDuration: CFTimeInterval { get }
    var fromColor: CGColor { get }
    var toColor: CGColor { get }
}

struct RHLayerAnimatorGradientConfiguration: RHLayerAnimatorGradientConfigurable {
    
    private(set) var animationDuration: CFTimeInterval = 0.5
    private(set) var fromColor: CGColor = UIColor.white.cgColor
    private(set) var toColor: CGColor = UIColor.lightGray.cgColor
}

protocol RHLayerAnimating {
    init()
    func addAnimation(to layer: CALayer)
}

class RHCAAnimationDelegateReceiver: NSObject, CAAnimationDelegate {
    
    private let animationDidStopCompletion: ()->()
    
    init(animationDidStopCompletion: @escaping ()->()) {
        self.animationDidStopCompletion = animationDidStopCompletion
        
        super.init()
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            animationDidStopCompletion()
        }
    }
}
    

final class RHLayerAnimatorGradient: RHLayerAnimating {
    
    private struct Constants {
        static let basicAnimationKeyPath = "colors"
        static let gradientAnimationAddKeyPath = "colorChange"
    }
    
    private let configuration: RHLayerAnimatorGradientConfigurable
    private let animation = CABasicAnimation(keyPath: Constants.basicAnimationKeyPath)
    private let gradient = CAGradientLayer()

    private lazy var gradientColors = [[configuration.fromColor, configuration.toColor],
                                       [configuration.toColor, configuration.fromColor]]
    private var currentGradient: Int = 0
    private var animationDelegate: RHCAAnimationDelegateReceiver?
    
    init(configuration: RHLayerAnimatorGradientConfigurable) {
        self.configuration = configuration
        
        setupAnimationDelegateReceiver()
    }
    
    convenience required init() {
        self.init(configuration: RHLayerAnimatorGradientConfiguration())
    }
    
    func addAnimation(to layer: CALayer) {
        gradient.frame = layer.bounds
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)

        layer.addSublayer(gradient)

        animateGradient()
    }
    
    private func animateGradient() {
        adjustCurrentGradientNumber()
    
        animation.duration = configuration.animationDuration
        animation.toValue = gradientColors[currentGradient]
        animation.fillMode = kCAFillModeForwards
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

// ------------------------------------------------
// ------------------------------------------------

protocol RHLayerAnimatorBlinkConfigurable {
    var animationDuration: CFTimeInterval { get }
    var blinkColor: CGColor { get }
}

struct RHLayerAnimatorBlinkConfiguration: RHLayerAnimatorBlinkConfigurable {

    private(set) var animationDuration: CFTimeInterval = 0.6
    private(set) var blinkColor: CGColor = UIColor.lightGray.cgColor
}

struct RHLayerAnimatorBlink: RHLayerAnimating {
    
    private struct Constants {
        static let basicAnimationKeyPath = "backgroundColor"
        static let gradientAnimationAddKeyPath = "colorChange"
    }
    
    private let configuration: RHLayerAnimatorBlinkConfigurable
    
    init(configuration: RHLayerAnimatorBlinkConfigurable) {
        self.configuration = configuration
    }
    
    init() {
        self.init(configuration: RHLayerAnimatorBlinkConfiguration())
    }
    
    func addAnimation(to layer: CALayer) {
        let animation = CABasicAnimation(keyPath: Constants.basicAnimationKeyPath)
        animation.duration = configuration.animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.toValue = configuration.blinkColor
        
        layer.add(animation, forKey: Constants.gradientAnimationAddKeyPath)
    }
}
