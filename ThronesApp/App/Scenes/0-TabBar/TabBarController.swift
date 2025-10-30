//
//  TabBarController.swift
//  ThronesApp
//
//  Created by Diggo Silva on 29/10/25.
//

import UIKit

class TabBarController: UITabBarController {
    
    let vc1 = UINavigationController(rootViewController: FeedViewController())
    let vc2 = UINavigationController(rootViewController:FavoriteViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewControllers()
    }
    
    private func configViewControllers() {
        vc1.tabBarItem.title = "Personagens"
        vc1.tabBarItem.image = UIImage(systemName: "person.2")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "person.2.fill")
        
        vc2.tabBarItem.title = "Favoritos"
        vc2.tabBarItem.image = UIImage(systemName: "star")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        
        viewControllers = [vc1, vc2]
    }
}
