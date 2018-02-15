
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
    static var ind = 0
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Fetched data from API simulation
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.removePhaceholder()
        }
        
        if ViewController.ind == 0 { // TODO [🌶]: remove
            let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ViewController")
            navigationController?.pushViewController(vc, animated: true)
            ViewController.ind += 1
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
    
    deinit {
        print("deinit 😀")
    }
}

final class RHPlaceholder {
    
    private var placeholders = [RHPlaceholderItem]()
    private var layerAnimator: RHLayerAnimating.Type
    
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
            
            animator?.addAnimation(to: layer)
        }
    }
    
    deinit {
        print("deinit 😀")
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

class RHLayerAnimatorGradient: NSObject, RHLayerAnimating {
    
    struct Constants {
        static let basicAnimationKeyPath = "colors"
        static let gradientAnimationAddKeyPath = "colorChange"
    }
    
    private let configuration: RHLayerAnimatorGradientConfigurable
    private var gradientSet = [[CGColor]]()
    private var currentGradient: Int = 0
    
    let animation = CABasicAnimation(keyPath: Constants.basicAnimationKeyPath)
    let gradient = CAGradientLayer()
    
    init(configuration: RHLayerAnimatorGradientConfigurable) {
        self.configuration = configuration
        
        super.init()
        
        gradientSet.append([configuration.fromColor, configuration.toColor])
        gradientSet.append([configuration.toColor, configuration.fromColor])
    }
    
    convenience override required init() {
        self.init(configuration: RHLayerAnimatorGradientConfiguration())
    }
    
    func addAnimation(to layer: CALayer) {
        gradient.frame = layer.bounds
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)

        layer.addSublayer(gradient)

        animateGradient()
    }
    
    func animateGradient() {
        if currentGradient < gradientSet.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
    
        animation.duration = configuration.animationDuration
        animation.toValue = gradientSet[currentGradient]
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self // TODO [🌶]: work with retain cycle in here
        
        gradient.add(animation, forKey: Constants.gradientAnimationAddKeyPath)
    }
    
    deinit {
        print("deinit 😀")
    }
}

extension RHLayerAnimatorGradient: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradient.colors = gradientSet[currentGradient]
            animateGradient()
        }
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
    private(set) var blinkColor: CGColor = UIColor.gray.cgColor
}

struct RHLayerAnimatorBlink: RHLayerAnimating {
    
    struct Constants {
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
    
    func removeDelegate() {
        
    }
}
