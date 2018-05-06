
import UIKit

class MyCell: UITableViewCell {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        getAllSubviews().forEach {
            $0.layer.cornerRadius = 5
        }
    }
    
    func getAnimableSubviews() -> [UIView] {
        return [UIView](getAllSubviews().dropFirst()) 
    }
    
    private func getAllSubviews() -> [UIView] {
        return [
            container,
            view1,
            view2,
            view3,
            view4
        ]
    }
}
