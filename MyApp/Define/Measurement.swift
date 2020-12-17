//
//  Measurement.swift
//  MyApp
//
//  Created by NHAN TRAN D. on 17/12/2020.
//  Copyright © 2020 Nhan Tran. All rights reserved.
//

import Foundation
import SwifterSwift

typealias Measurement = App.Measurement

extension App {

    struct Measurement {
        static var tabBarHeight: CGFloat {
            if iPhoneX || iPhoneXr || iphone12 || iphone12ProMax {
                return 89
            } else {
                return 55
            }
        }

        static var statusBarHeight: CGFloat {
            if iPhoneX || iPhoneXr || iphone12 || iphone12ProMax {
                return 44
            } else {
                return 20
            }
        }

        static let navigationBarHeight: CGFloat = 50
    }
}
