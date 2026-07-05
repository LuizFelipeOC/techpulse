//
//  OnboardingManager.swift
//  techpulse
//
//  Created by Luiz Felipe on 05/07/26.
//

import Foundation


struct OnboardingManager {
    private static let kHasSeenOnboarding = "kHasSeenOnboarding"
    
    static var hasSeenOnboarding: Bool {
        get {UserDefaults.standard.bool(forKey: kHasSeenOnboarding)}
        set {UserDefaults.standard.set(newValue, forKey: kHasSeenOnboarding)}
    }
}
