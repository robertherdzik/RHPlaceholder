
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
        
        roundImageContainers()
        addPlaceholder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.remove()
        }
    }
    
    private func addPlaceholder() {
        let labels: [UIView] = [photoImgView4!,
                                numberOfMiles!,
                                name!,
                                surname!,
                                age!,
                                email!,
                                birthDate!,
                                sex!]
        placeholderMarker.register(placeholders: labels)
    }

    @objc private func remove() {
        placeholderMarker.removeLayer()
    }
    
    private func roundImageContainers() {
        photoView1.layer.cornerRadius = photoView1.bounds.width/2
        photoView2.layer.cornerRadius = photoView2.bounds.width/2
        photoView3.layer.cornerRadius = photoView3.bounds.width/2
        photoImgView4.layer.cornerRadius = photoImgView4.bounds.width/2
        photoImgView4.layer.masksToBounds = true
    }
}

class RHPlaceholder {
    
    private var placeholders = [RHPlaceholderItem]()
    
    func register(placeholders: [UIView]) {
        placeholders.forEach { label in
            self.placeholders.append(RHPlaceholderItem(originItem: label,
                                                       cover: UIView()))
        }
    
        addLayer()
    }
    
    private func addLayer() {
        placeholders.forEach({ placeholder in
            let layer = placeholder.cover
            layer.backgroundColor = UIColor.lightGray
            layer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            layer.frame = placeholder.originItem.bounds
            placeholder.originItem.addSubview(layer)
        })
        
        startShimmering()
    }
    
    func removeLayer() {
        placeholders.forEach({ placeholder in
            let layer = placeholder.cover
            layer.removeFromSuperview()
        })
    }
    
    func startShimmering() {
        placeholders.forEach({ placeholder in
            let layer = placeholder.cover
            
            let animation = CABasicAnimation()
            animation.keyPath = "backgroundColor"
            animation.toValue = UIColor.gray.cgColor
            animation.duration = 0.6
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            animation.repeatCount = Float.greatestFiniteMagnitude
            layer.layer.add(animation, forKey: "bg")
        })
    }
}

struct RHPlaceholderItem {
    
    let originItem: UIView
    var cover: UIView
}
