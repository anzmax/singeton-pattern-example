import Foundation
import UIKit

class UserPreferences {
    
    static let shared = UserPreferences()
    private let userPreferences: UserDefaults
    
    private init() {
        userPreferences = UserDefaults.standard
    }
    
    enum Preferences {
        
        enum UserCredentials: String {
            case username
            case password
            case passwordVisible
        }
        
        enum State: String {
            case appFirstRun
            case dateLastRun
            case currentVersion
        }
    }
    
    func setBooleanForKey(_ boolean: Bool, key: String) {
        if key != "" {
            userPreferences.set(boolean, forKey: key)
        }
    }
    
    func getBooleanForKey(_ key: String) -> Bool {
        if let isBooleanValue = userPreferences.value(forKey: key) as? Bool {
            print("Key \(key) is \(isBooleanValue)")
            return true
        } else {
            print("Key \(key) is false")
            return false
        }
    }
    
    func isPasswordVisible() -> Bool {
        let isVisible = userPreferences.bool(forKey: Preferences.UserCredentials.passwordVisible.rawValue)
        
        if isVisible {
            return true
        } else {
            return false
        }
    }
    
    func setPasswordVisibility(_ visible: Bool) {
        userPreferences.set(visible, forKey: Preferences.UserCredentials.passwordVisible.rawValue)
    }
}
