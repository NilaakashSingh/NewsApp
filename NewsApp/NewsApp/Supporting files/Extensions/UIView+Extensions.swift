//
//  UIView+Extensions.swift
//  NewsApp
//
//  Created by Nilaakash Singh on 19/11/2021.
//

import UIKit

extension UIView {
    func blink(duration: TimeInterval) {
        let initialAlpha: CGFloat = 1
        let finalAlpha: CGFloat = 0.2
        alpha = initialAlpha
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .repeat) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.alpha = finalAlpha
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.alpha = initialAlpha
            }
        }
    }
}
