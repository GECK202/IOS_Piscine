//
//  TabBarController.swift
//  MapKitApp
//
//  Created by Valeria Karon on 2/15/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if "\(type(of: viewController))" == "TableViewController" {
            let vc = viewController as! TableViewController
            vc.conclusion = { l in
                print(l)
                let mvc = tabBarController.viewControllers?[0] as! MapViewController
                mvc.locationString = l
                tabBarController.selectedIndex = 0
            }
        }
        
        return true
    }

}
