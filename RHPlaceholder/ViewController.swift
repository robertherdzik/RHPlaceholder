
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
        
        view.clipsToBounds = true
        roundProfileImageContainers()
        
        // Add placeholder
        addPlaceholder()
    }
    
    static var testValue = 1

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Fetched data from API simulation
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.removePhaceholder()
        }
        
        
        if ViewController.testValue == 1 {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            navigationController?.pushViewController(vc, animated: true)
            ViewController.testValue -= 1
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


