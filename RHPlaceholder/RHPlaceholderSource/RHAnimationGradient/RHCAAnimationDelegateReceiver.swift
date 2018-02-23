import UIKit

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
