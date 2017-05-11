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
	@IBOutlet var pdfView: PDFView!

	override var windowNibName: String! {
		return "EULA"
	}
	
	override func windowDidLoad() {
		super.windowDidLoad()
		
		guard let docURL = Bundle.main.url(forResource: "FedExWebServicesEndUserLicenseAgreement-ver7-July2015", withExtension: "pdf") else { return }
		
		let pdfDocument = PDFDocument(url: docURL)
		
		pdfView.document = pdfDocument
	}
	
	func windowWillClose(_ notification: Notification) {
		NSApplication.shared().stopModal()
	}
}
