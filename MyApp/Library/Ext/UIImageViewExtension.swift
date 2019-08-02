//
//  UIImageViewExtension.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/15/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }

    func setImageFromUrl(stringImageUrl url: String?) {
        self.image = nil
        guard let url = url else {
            return
        }

        DispatchQueue.global(qos: .default).async {
            // Fetch data on background thread to improve scrolling
            if let url = NSURL(string: url) {
                if let data = NSData(contentsOf: url as URL) {
                    DispatchQueue.main.async {
                        // Update image on main thread once fetched
                        self.image = UIImage(data: data as Data)
                    }
                }
            }
        }
    }

    func rotate() {
        if self.layer.animation(forKey: "cdImage") == nil {
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotateAnimation.toValue = Double.pi * 2
            rotateAnimation.duration = 13
            rotateAnimation.repeatCount = HUGE
            rotateAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            self.layer.speed = 1
            self.layer.add(rotateAnimation, forKey: "cdImage")
        }
    }

    func pauseRotateCD() {
        let pauseTime = self.layer.convertTime(CACurrentMediaTime(), from: nil)
        self.layer.speed = 0.0
        self.layer.timeOffset = pauseTime
    }

    func resumeRotateCD() {
        let pauseTime = self.layer.timeOffset
        self.layer.speed = 1.0
        self.layer.timeOffset = 0.0
        self.layer.beginTime = 0.0
        self.layer.beginTime = layer.convertTime(CACurrentMediaTime(), from: nil) - pauseTime
    }

    func stopRotateCD() {
        self.layer.removeAllAnimations()
    }
}
