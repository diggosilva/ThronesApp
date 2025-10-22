//
//  Extensions.swift
//  ThronesApp
//
//  Created by Diggo Silva on 21/10/25.
//

import Foundation
import UIKit

extension UIViewController {
    func showCustomAlert(title: String, message: String, buttonTitle: String, handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            handler?()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
