//
//  ViewController1.swift
//  RHPlaceholder
//
//  Created by Robert Herdzik on 05/05/2018.
//  Copyright © 2018 Robert Herdzik. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    let marker = Placeholder()
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var views = [
            container,
            view1,
            view2,
            view3,
            view4
        ]
        
        views.forEach {
            $0?.layer.cornerRadius = 8
        }
    
        views.removeFirst()
        
        let forMark = views
        marker.register(forMark as! [UIView])
        marker.startAnimation()
    }

    

}
