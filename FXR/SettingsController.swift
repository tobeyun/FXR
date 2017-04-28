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
	@IBOutlet weak var productionCheckBox: NSButton!
	@IBOutlet weak var companyName: NSTextField!
	@IBOutlet weak var addressLine: NSTextField!
	@IBOutlet weak var city: NSTextField!
	@IBOutlet weak var state: NSTextField!
	@IBOutlet weak var zipCode: NSTextField!
	@IBOutlet weak var ltlAccountNumber: NSTextField!
	@IBOutlet weak var ltlCompany: NSTextField!
	@IBOutlet weak var ltlAddress: NSTextField!
	@IBOutlet weak var ltlCity: NSTextField!
	@IBOutlet weak var ltlState: NSTextField!
	@IBOutlet weak var ltlZipCode: NSTextField!
	@IBOutlet weak var ltlThirdParty: NSButton!
	
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
		
		productionCheckBox.state = UserDefaults.standard.integer(forKey: "production")
		
		companyName.stringValue = "\((UserDefaults.standard.string(forKey: "company")) ?? "")"
		addressLine.stringValue = "\((UserDefaults.standard.string(forKey: "address")) ?? "")"
		city.stringValue = "\((UserDefaults.standard.string(forKey: "city")) ?? "")"
		state.stringValue = "\((UserDefaults.standard.string(forKey: "state")) ?? "")"
		zipCode.stringValue = "\((UserDefaults.standard.string(forKey: "zip")) ?? "")"
	
		ltlAccountNumber.stringValue = "\((KeychainManager.queryData(itemKey: "ltlaccount")) as? String ?? "")"
		ltlCompany.stringValue = "\((UserDefaults.standard.string(forKey: "ltlcompany")) ?? "")"
		ltlAddress.stringValue = "\((UserDefaults.standard.string(forKey: "ltladdress")) ?? "")"
		ltlCity.stringValue = "\((UserDefaults.standard.string(forKey: "ltlcity")) ?? "")"
		ltlState.stringValue = "\((UserDefaults.standard.string(forKey: "ltlstate")) ?? "")"
		ltlZipCode.stringValue = "\((UserDefaults.standard.string(forKey: "ltlzip")) ?? "")"
		ltlThirdParty.state = UserDefaults.standard.integer(forKey: "ltlthirdparty")
	}
	
	func windowWillClose(_ notification: Notification) {
		if (KeychainManager.queryData(itemKey: "key")?.stringValue != webCredentialKey.stringValue) {
			KeychainManager.deleteData(itemKey: "key")
			KeychainManager.addData(itemKey: "key", itemValue: webCredentialKey.stringValue)
		}
		
		if (KeychainManager.queryData(itemKey: "password")?.stringValue != webCredentialPassword.stringValue) {
			KeychainManager.deleteData(itemKey: "password")
			KeychainManager.addData(itemKey: "password", itemValue: webCredentialPassword.stringValue)
		}
		
		if (KeychainManager.queryData(itemKey: "meter")?.stringValue != webCredentialKey.stringValue) {
			KeychainManager.deleteData(itemKey: "meter")
			KeychainManager.addData(itemKey: "meter", itemValue: meterNumber.stringValue)
		}
		
		
		if (KeychainManager.queryData(itemKey: "account")?.stringValue != accountNumber.stringValue) {
			KeychainManager.deleteData(itemKey: "account")
			KeychainManager.addData(itemKey: "account", itemValue: accountNumber.stringValue)
		}
		
		if (KeychainManager.queryData(itemKey: "ltlaccount")?.stringValue != webCredentialKey.stringValue) {
			KeychainManager.deleteData(itemKey: "ltlaccount")
			KeychainManager.addData(itemKey: "ltlaccount", itemValue: ltlAccountNumber.stringValue)
		}
		
		UserDefaults.standard.set(productionCheckBox.stringValue, forKey: "production")
		UserDefaults.standard.set("https://wsbeta.fedex.com:443/web-services/", forKey: "ws-url")
		
		if (UserDefaults.standard.integer(forKey: "production") == 1) {
			UserDefaults.standard.set("https://ws.fedex.com:443/web-services/", forKey: "ws-url")
		}
		
		UserDefaults.standard.set(companyName.stringValue, forKey: "company")
		UserDefaults.standard.set(addressLine.stringValue, forKey: "address")
		UserDefaults.standard.set(city.stringValue, forKey: "city")
		UserDefaults.standard.set(state.stringValue, forKey: "state")
		UserDefaults.standard.set(zipCode.stringValue, forKey: "zip")
		
		UserDefaults.standard.set(ltlCompany.stringValue, forKey: "ltlcompany")
		UserDefaults.standard.set(ltlAddress.stringValue, forKey: "ltladdress")
		UserDefaults.standard.set(ltlCity.stringValue, forKey: "ltlcity")
		UserDefaults.standard.set(ltlState.stringValue, forKey: "ltlstate")
		UserDefaults.standard.set(ltlZipCode.stringValue, forKey: "ltlzip")
		UserDefaults.standard.set(ltlThirdParty.stringValue, forKey: "ltlthirdparty")
		
		NSApplication.shared().stopModal()
	}
}
