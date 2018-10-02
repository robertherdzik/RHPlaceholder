import UIKit

extension UIColor {

    /// Usage:
    /// let color = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF)
    /// let color2 = UIColor(rgb: 0xFFFFFF)
    
    convenience init(red: Int, green: Int, blue: Int) {
        let decimalRange = 0...255
        assert(decimalRange ~= red, "Invalid red component")
        assert(decimalRange ~= green, "Invalid green component")
        assert(decimalRange ~= blue, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
