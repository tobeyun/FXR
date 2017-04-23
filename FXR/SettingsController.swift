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
	@IBOutlet weak var companyName: NSTextField!
	@IBOutlet weak var addressLine: NSTextField!
	@IBOutlet weak var city: NSTextField!
	@IBOutlet weak var state: NSTextField!
	@IBOutlet weak var zipCode: NSTextField!
	
	override var windowNibName: String! {
		return "Settings"
	}
	
	override func windowDidLoad() {
		super.windowDidLoad()
		
//		KeychainManager.addData(itemKey: "key", itemValue: "ATjhnRZwKmclwko3")
//		KeychainManager.addData(itemKey: "password", itemValue: "yrsrYK0DeXj6RbbKrn51p8f8O")
//		KeychainManager.addData(itemKey: "meter", itemValue: "118784833")
//		KeychainManager.addData(itemKey: "account", itemValue: "510087100")
		
		accountNumber.stringValue = "\((KeychainManager.queryData(itemKey: "account")) as? String ?? "")"
		meterNumber.stringValue = "\((KeychainManager.queryData(itemKey: "meter")) as? String ?? "")"
		webCredentialKey.stringValue = "\((KeychainManager.queryData(itemKey: "key")) as? String ?? "")"
		webCredentialPassword.stringValue = "\((KeychainManager.queryData(itemKey: "password")) as? String ?? "")"
		
		companyName.stringValue = "\((KeychainManager.queryData(itemKey: "company")) as? String ?? "")"
		addressLine.stringValue = "\((KeychainManager.queryData(itemKey: "address")) as? String ?? "")"
		city.stringValue = "\((KeychainManager.queryData(itemKey: "city")) as? String ?? "")"
		state.stringValue = "\((KeychainManager.queryData(itemKey: "state")) as? String ?? "")"
		zipCode.stringValue = "\((KeychainManager.queryData(itemKey: "zip")) as? String ?? "")"
	}
	
	func windowWillClose(_ notification: Notification) {
		KeychainManager.deleteData(itemKey: "key")
		KeychainManager.deleteData(itemKey: "password")
		KeychainManager.deleteData(itemKey: "meter")
		KeychainManager.deleteData(itemKey: "account")
		
		KeychainManager.deleteData(itemKey: "company")
		KeychainManager.deleteData(itemKey: "address")
		KeychainManager.deleteData(itemKey: "city")
		KeychainManager.deleteData(itemKey: "state")
		KeychainManager.deleteData(itemKey: "zip")
		
		KeychainManager.addData(itemKey: "key", itemValue: webCredentialKey.stringValue)
		KeychainManager.addData(itemKey: "password", itemValue: webCredentialPassword.stringValue)
		KeychainManager.addData(itemKey: "meter", itemValue: meterNumber.stringValue)
		KeychainManager.addData(itemKey: "account", itemValue: accountNumber.stringValue)
		
		KeychainManager.addData(itemKey: "company", itemValue: companyName.stringValue)
		KeychainManager.addData(itemKey: "address", itemValue: addressLine.stringValue)
		KeychainManager.addData(itemKey: "city", itemValue: city.stringValue)
		KeychainManager.addData(itemKey: "state", itemValue: state.stringValue)
		KeychainManager.addData(itemKey: "zip", itemValue: zipCode.stringValue)
		
		NSApplication.shared().stopModal()
	}
}
