//
//  IsProcessTrusted.swift
//  Automatically Move Mouse Pointer To Default Button in a dialog box for mac
//
//  Created by kyo ago on 2018/07/15.
//  Copyright © 2018 kyo ago. All rights reserved.
//

import Foundation
import Cocoa

class IsProcessTrusted {
    typealias Callback = () -> Void
    var success: Callback?

    func start(_ success: @escaping Callback) {
        self.success = success

        let checkOptionPrompt = kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString
        let options: CFDictionary = [checkOptionPrompt: true] as NSDictionary
        let result = AXIsProcessTrustedWithOptions(options)
        if result {
            success()
            return
        }
        Timer.scheduledTimer(timeInterval: 1.0,
                             target: self,
                             selector: #selector(IsProcessTrusted.watchAXIsProcess(_:)),
                             userInfo: nil,
                             repeats: true)
    }

    @objc func watchAXIsProcess(_ timer: Timer) {
        if !AXIsProcessTrusted() {
            return
        }
        timer.invalidate()
        success!()
    }
}
