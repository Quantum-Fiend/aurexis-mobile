package com.tripay.security

import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.LifecycleOwner
import java.util.Date

class SecurityLockManager : DefaultLifecycleObserver {
    var isLocked = true
    private var lastActiveTime = Date()
    private val autoLockInterval = 300 * 1000 // 5 minutes in ms

    override fun onStop(owner: LifecycleOwner) {
        lastActiveTime = Date()
    }

    override fun onStart(owner: LifecycleOwner) {
        if (Date().time - lastActiveTime.time > autoLockInterval) {
            isLocked = true
            // Trigger biometric prompt logic here
        }
    }
}
