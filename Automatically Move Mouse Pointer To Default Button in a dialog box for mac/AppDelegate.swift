//
//  AppDelegate.swift
//  Automatically Move Mouse Pointer To Default Button in a dialog box for mac
//
//  Created by kyo ago on 2018/07/04.
//  Copyright © 2018 kyo ago. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: StatusItem!
    var applications: Applications?
    @IBOutlet weak var menu: NSMenu!

    @IBAction func onClickMenuItem(_ sender: NSMenuItem) {
        guard let statusItem = self.statusItem else {
            return
        }
        guard let identifier = sender.identifier?.rawValue else {
            return
        }
        if identifier == "StartAtLogin" {
            statusItem.onClickStartAtLogin()
        } else if identifier == "EventStatus" {
            statusItem.onClickEventStatus()
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.statusItem = StatusItem(menu)

        let isProcessTrusted = IsProcessTrusted()
        isProcessTrusted.start({
            print("isProcessTrusted.started")
            self.applications = Applications()
            self.applications?.start()
        })
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        print("applicationWillTerminate")
    }
}

