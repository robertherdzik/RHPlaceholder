import UIKit
 
protocol LayerAnimating {
    init()
    func addAnimation(to layer: CALayer)
    func removeGradientLayer()
}
