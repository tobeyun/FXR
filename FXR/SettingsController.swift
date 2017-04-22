//
//  SettingsController.swift
//  FXR
//
//  Created by Tobey Unruh on 4/21/17.
//  Copyright © 2017 Tobey Unruh. All rights reserved.
//

import Cocoa

class SettingsController: NSWindowController, NSWindowDelegate
{
	@IBOutlet weak var accountNumber: NSTextField!
	@IBOutlet weak var meterNumber: NSTextField!
	@IBOutlet weak var webCredentialKey: NSTextField!
	@IBOutlet weak var webCredentialPassword: NSTextField!
	
	override var windowNibName: String! {
		return "Settings"
	}
	
	override func windowDidLoad() {
		super.windowDidLoad()
		
//		try? KeychainManager.addData(itemKey: "key", itemValue: "ATjhnRZwKmclwko3")
//		try? KeychainManager.addData(itemKey: "password", itemValue: "yrsrYK0DeXj6RbbKrn51p8f8O")
//		try? KeychainManager.addData(itemKey: "meter", itemValue: "118784833")
//		try? KeychainManager.addData(itemKey: "account", itemValue: "510087100")
		
		accountNumber.stringValue = "\((try? KeychainManager.queryData(itemKey: "account"))! as! String)"
		meterNumber.stringValue = "\((try? KeychainManager.queryData(itemKey: "meter"))! as! String)"
		webCredentialKey.stringValue = "\((try? KeychainManager.queryData(itemKey: "key"))! as! String)"
		webCredentialPassword.stringValue = "\((try? KeychainManager.queryData(itemKey: "password"))! as! String)"
	}
	
	func windowWillClose(_ notification: Notification) {
		try? KeychainManager.deleteData(itemKey: "key")
		try? KeychainManager.deleteData(itemKey: "password")
		try? KeychainManager.deleteData(itemKey: "meter")
		try? KeychainManager.deleteData(itemKey: "account")
		
		try? KeychainManager.addData(itemKey: "key", itemValue: webCredentialKey.stringValue)
		try? KeychainManager.addData(itemKey: "password", itemValue: webCredentialPassword.stringValue)
		try? KeychainManager.addData(itemKey: "meter", itemValue: meterNumber.stringValue)
		try? KeychainManager.addData(itemKey: "account", itemValue: accountNumber.stringValue)
		
		NSApplication.shared().stopModal()
	}
}
