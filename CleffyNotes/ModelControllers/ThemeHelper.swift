//
//  ThemeHelper.swift
//  CleffyNotes
//
//  Created by Cora Jacobson on 6/23/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import Foundation

class ThemeHelper {
    let themePreferenceKey = "themePreference"
    
    func setThemePreferenceToPurple() {
        let themePreference = "Purple"
        UserDefaults.standard.set(themePreference, forKey: themePreferenceKey)
    }
    
    func setThemePreferenceToGreen() {
        let themePreference = "Green"
        UserDefaults.standard.set(themePreference, forKey: themePreferenceKey)
    }
    
    func setThemePreferenceToBlue() {
        let themePreference = "Blue"
        UserDefaults.standard.set(themePreference, forKey: themePreferenceKey)
    }
    
    var themePreference: String? {
        if let theme = UserDefaults.standard.string(forKey: themePreferenceKey) {
            return theme
        } else {
            return nil
        }
    }
    
    init() {
        if themePreference == nil {
            setThemePreferenceToPurple()
        }
    }
    
}
