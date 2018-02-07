
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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

class RHPlaceholder {
    
    private var placeholders = [RHPlaceholderItem]()
    private var layerAnimator: RHLayerAnimating
    
    init(layerAnimator: RHLayerAnimating) {
        self.layerAnimator = layerAnimator
    }
    
    convenience init() {
        self.init(layerAnimator: RHLayerAnimatorDefault())
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
        shield.backgroundColor = UIColor.lightGray
        shield.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        shield.frame = placeholder.originItem.bounds
        placeholder.originItem.addSubview(shield)
    }
    
    private func animate() {
        placeholders.forEach { [weak self] in
            let layer = $0.shield.layer
            self?.layerAnimator.addAnimation(to: layer)
        }
    }
}

protocol RHLayerAnimating {
    func addAnimation(to layer: CALayer)
}

struct RHLayerAnimatorDefault: RHLayerAnimating {
    
    func addAnimation(to layer: CALayer) {
        let animation = CABasicAnimation()
        animation.keyPath = "backgroundColor"
        animation.toValue = UIColor.gray.cgColor
        animation.duration = 0.6
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.repeatCount = Float.greatestFiniteMagnitude
        
        layer.add(animation, forKey: "bg_animation")
    }
}

struct RHPlaceholderItem {
    
    let originItem: UIView // TODO [🌶]: consider 'weak'
    let shield = UIView()
    
    init(originItem: UIView) {
        self.originItem = originItem
    }
}
