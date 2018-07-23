//
//  StatusItem.swift
//  Automatically Move Mouse Pointer To Default Button in a dialog box for mac
//
//  Created by kyo ago on 2018/07/14.
//  Copyright © 2018 kyo ago. All rights reserved.
//

import Foundation
import Cocoa

class StatusItem {
    let statusItem: NSStatusItem
    let loginItem = LoginItem()

    init(_ menu: NSMenu) {
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = self.statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusbarIcon"))
        }
        self.statusItem.menu = menu
        self.getItem("StartAtLogin")?.state = self.loginItem.isAdded() ? .on : .mixed
    }

    func onClickStartAtLogin() {
        if self.loginItem.isAdded() {
            self.loginItem.delete()
        } else {
            self.loginItem.add()
        }
        self.getItem("StartAtLogin")?.state = self.loginItem.isAdded() ? .on : .mixed
    }

    func onClickEventStatus() {
        
    }

    private func getItem(_ identifier: String) -> NSMenuItem? {
        return self.statusItem.menu?.items.filter({ $0.identifier?.rawValue == "StartAtLogin" }).first
    }
}
