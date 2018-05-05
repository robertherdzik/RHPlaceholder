import UIKit
 
protocol LayerAnimating {
    var originLayerColor: CGColor { get }
    
    init()
    func getAnimatedLayer(withReferenceFrame frame: CGRect) -> CALayer
}
