//
//  GeneralUtils.swift
//  Mango (Social Manga)
//
//  Created by bhrs on 10/5/19.
//  Copyright © 2019 Blake Harrison. All rights reserved.
//

import Foundation
import UIKit

class GeneralUtils {
    static func isDarkModeEnabled()-> Bool {
        if #available(iOS 12.0, *) {
            if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
                return true
            } else {
                return false
            }
        } else {
            // Fallback on earlier versions
        }
        return false
    }
}
