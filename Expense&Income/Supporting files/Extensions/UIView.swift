//
//  UIView.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 04.06.2021.
//

import UIKit

extension UIView {
    func showAnimationWithHaptic() {
            let haptic = UIImpactFeedbackGenerator(style: .medium)
            haptic.prepare()
            haptic.impactOccurred()
            
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
                           }) {  (done) in
                UIView.animate(withDuration: 0.1,
                               delay: 0,
                               options: .curveLinear,
                               animations: { [weak self] in
                                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                               })
            }
        }
}
