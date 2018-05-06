import UIKit

public class CAAnimationDelegateReceiver: NSObject, CAAnimationDelegate {
    
    private let animationDidStopCompletion: ()->()
    
    init(animationDidStopCompletion: @escaping ()->()) {
        self.animationDidStopCompletion = animationDidStopCompletion
        
        super.init()
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            animationDidStopCompletion()
        }
    }
}
