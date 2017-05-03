//
//  SettingsController.swift
//  FXR
//
//  Created by Tobey Unruh on 4/21/17.
//  Copyright © 2017 Tobey Unruh. All rights reserved.
//

import Cocoa

class EulaController: NSWindowController, NSWindowDelegate
{
	
	@IBOutlet weak var affirmAgreementCheckBox: NSButton!
	
	@IBAction func openAgreement(_ sender: Any) {
		NSWorkspace.shared().open(URL(string: "https://github.com/tobeyun/FXR/blob/master/images/FedExWebServicesEndUserLicenseAgreement-ver7-July2015.pdf")!)
		
		affirmAgreementCheckBox.isEnabled = true
	}
	
	override var windowNibName: String! {
		return "EULA"
	}
	
	override func windowDidLoad() {
		super.windowDidLoad()
		
		if let x = KeychainManager.queryData(itemKey: "eula") as? String {
			affirmAgreementCheckBox.isEnabled = x == "1"
			affirmAgreementCheckBox.state = (x == "1" ? 1 : 0)
		}
	}
	
	func windowWillClose(_ notification: Notification) {
		NSApplication.shared().stopModal()
		
		KeychainManager.deleteData(itemKey: "eula")
		
		if affirmAgreementCheckBox.state == 0 {
			NSApplication.shared().terminate(self)
		} else {
			KeychainManager.addData(itemKey: "eula", itemValue: "\(affirmAgreementCheckBox.state)")
		}
		
	}
}
