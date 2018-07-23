//
//  LoginItem.swift
//  Automatically Move Mouse Pointer To Default Button in a dialog box for mac
//
//  Created by kyo ago on 2018/07/18.
//  Copyright © 2018 kyo ago. All rights reserved.
//

import Foundation
import Cocoa

class LoginItem {
    func add() {
        guard let template = getTemplate("AddLoginItem") else {
            return
        }
        guard let localizedName = NSRunningApplication.current.localizedName else {
            return
        }
        let script = String(format: template, Bundle.main.bundlePath, localizedName)
        guard let result = executeAndReturnError(script) else {
            return
        }
        print("LoginItem.add() -> \(result)")
    }
    func isAdded() -> Bool {
        guard let template = getTemplate("GetLoginItems") else {
            return false
        }
        guard let result = executeAndReturnError(template) else {
            return false
        }
        guard let appList = result.coerce(toDescriptorType: typeAEList) else {
            return false
        }
        var appArray: [String] = []
        for i in 1 ... appList.numberOfItems {
            if let name = appList.atIndex(i)?.stringValue {
                appArray.append(name)
            }
        }
        guard let localizedName = NSRunningApplication.current.localizedName else {
            return false
        }
        return appArray.contains(localizedName)
    }
    func delete() {
        guard let template = getTemplate("DeleteLoginItem") else {
            return
        }
        guard let localizedName = NSRunningApplication.current.localizedName else {
            return
        }
        let script = String(format: template, localizedName, localizedName)
        guard let result = executeAndReturnError(script) else {
            return
        }
        print("LoginItem.delete() -> \(result)")
    }

    private func getTemplate(_ forResource: String) -> String? {
        let filePath = Bundle.main.path(forResource: forResource, ofType: "scpt")
        return try? String(contentsOfFile: filePath!, encoding: String.Encoding.utf8)
    }

    private func executeAndReturnError(_ source: String) -> NSAppleEventDescriptor? {
        let script = NSAppleScript(source: source)
        
        var error: NSDictionary?
        let result = script?.executeAndReturnError(&error)
        
        guard error == nil else {
            print("LoginItem.executeAndReturnError \(String(describing: error))")
            return nil
        }
        return result
    }
}
