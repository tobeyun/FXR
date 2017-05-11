//
//  EULAController.swift
//  FXR
//
//  Created by Tobey Unruh on 5/10/17.
//  Copyright © 2017 Tobey Unruh. All rights reserved.
//

import Cocoa
import Quartz

class EULAController: NSWindowController, NSWindowDelegate
{
	@IBOutlet weak var pdfView: PDFView!
	
	override var windowNibName: String! {
		return "EULA"
	}
	
	override func windowDidLoad() {
		super.windowDidLoad()
		
		guard let docPath = NSDataAsset(name: "EULA") else { return } // .path(forResource: "FedExWebServicesEndUserLicenseAgreement-ver7-July2015", ofType: "pdf") else { return }
		
		let pdfDocument = PDFDocument(data: docPath.data)
		
		pdfView.document = pdfDocument
	}
	
	func windowWillClose(_ notification: Notification) {
		NSApplication.shared().stopModal()
	}
}
