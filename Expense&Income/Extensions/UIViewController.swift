//
//  UIViewController.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

extension UIViewController {
    
    func setCornerRadiusToCircle(_ views: UIView...) {
        views.forEach{ view in
            view.layer.cornerRadius = view.frame.height / 2
        }
    }
    
    func setBackgroundImage(with image: String, for view: UIView) {
        let imageView = UIImageView(image: UIImage(named: image))

        if view is UIButton {
            imageView.frame = view.bounds
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = view.frame.height / 2
            view.addSubview(imageView)
        } else {
            imageView.frame = view.bounds
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.center = view.center
            view.addSubview(imageView)
            view.sendSubviewToBack(imageView)
        }
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}
