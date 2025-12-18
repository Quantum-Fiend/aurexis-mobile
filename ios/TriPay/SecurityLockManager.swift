import Foundation
import LocalAuthentication

class SecurityLockManager: ObservableObject {
    @Published var isLocked = true
    private var lastActiveTime: Date = Date()
    private let autoLockInterval: TimeInterval = 300 // 5 minutes
    
    func appDidResignActive() {
        lastActiveTime = Date()
    }
    
    func appDidBecomeActive() {
        if Date().timeIntervalSince(lastActiveTime) > autoLockInterval {
            isLocked = true
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Unlock TriPay") { success, error in
                DispatchQueue.main.async {
                    if success {
                        self.isLocked = false
                    }
                }
            }
        }
    }
}
