//
//  GlobalStructs.swift
//  FXR
//
//  Created by Tobey Unruh on 4/21/17.
//  Copyright © 2017 Tobey Unruh. All rights reserved.
//

import Foundation

struct WebAuthenticationDetail : CustomStringConvertible
{
	fileprivate let _parentCredential: WebAuthenticationCredential?
	fileprivate let _userCredential: WebAuthenticationCredential
	
	var description: String { return "\(parentCredential())\(userCredential())" }
	
	init(parentCredential: WebAuthenticationCredential?, userCredential: WebAuthenticationCredential)
	{
		_parentCredential = parentCredential
		_userCredential = userCredential
	}
	
	func parentCredential() -> String { return (_parentCredential == nil ? "" : "<ParentCredential>\(_parentCredential!)</ParentCredential>") }
	func userCredential() -> String { return "<UserCredential>\(_userCredential)</UserCredential>" }
}

struct WebAuthenticationCredential : CustomStringConvertible
{
	fileprivate let _key: String
	fileprivate let _password: String
	
	var description: String { return "\(key())\(password())" }
	
	init(key: String, password: String)
	{
		_key = key
		_password = password
	}
	
	func key() -> String { return "<Key>\(_key)</Key>" }
	func password() -> String { return "<Password>\(_password)</Password>" }
}

struct ClientDetail : CustomStringConvertible
{
	fileprivate let _accountNumber: String
	fileprivate let _meterNumber: String
	fileprivate let _integratorId: String?
	fileprivate let _region: ExpressRegionCode?
	fileprivate let _localization: Localization?
	
	var description: String { return "\(accountNumber())\(meterNumber())\(integratorId())\(region())\(localization())" }
	
	init(accountNumber: String, meterNumber: String, integratorId: String?, region: ExpressRegionCode?, localization: Localization?)
	{
		_accountNumber = accountNumber
		_meterNumber = meterNumber
		_integratorId = integratorId
		_region = region
		_localization = localization
	}
	
	func accountNumber() -> String { return "<AccountNumber>\(_accountNumber)</AccountNumber>" }
	func meterNumber() -> String { return "<MeterNumber>\(_meterNumber)</MeterNumber>" }
	func integratorId() -> String { return (_integratorId == nil ? "" : "<IntegratorId>\(_integratorId!)</IntegratorId>") }
	func region() -> String { return (_region == nil ? "" : "<Region>\(_region!)</Region>") }
	func localization() -> String { return (_localization == nil ? "" : "<Localization>\(_localization!)</Localization>") }
}

struct TransactionDetail : CustomStringConvertible
{
	fileprivate let _customerTransactionId: String?
	fileprivate let _localization: Localization?
	
	var description: String { return "\(customerTransactionId())\(localization())" }
	
	init(customerTransactionId: String?, localization: Localization?)
	{
		_customerTransactionId = customerTransactionId
		_localization = localization
	}
	
	func customerTransactionId() -> String { return (_customerTransactionId == nil ? "" : "<CustomerTransactionId>\(_customerTransactionId!)</CustomerTransactionId>") }
	func localization() -> String { return (_localization == nil ? "" : "<Localization>\(_localization!)</Localization>") }
}

struct fNotification : CustomStringConvertible
{
	fileprivate let _severity: NotificationSeverityType?
	fileprivate let _source: String?
	fileprivate let _code: String?
	fileprivate let _message: String?
	fileprivate let _localizedMessage: String?
	fileprivate let _messageParameters: [NotificationParameter]?
	
	var description: String { return "\(severity())\(source())\(code())\(message())\(localizedMessage())\(messageParameters())" }
	
	init(severity: NotificationSeverityType?, source: String?, code: String?, message: String?, localizedMessage: String?, messageParameters: [NotificationParameter]?)
	{
		_severity = severity
		_source = source
		_code = code
		_message = message
		_localizedMessage = localizedMessage
		_messageParameters = messageParameters
	}
	
	func severity() -> (name: String, value: NotificationSeverityType?) { return (_severity == nil ? (name: "Severity", value: nil) : (name: "Severity", value: _severity!)) }
	func source() -> (name: String, value: String) { return (_source == nil ? (name: "Source", value: "") : (name: "Source", value: _source!)) }
	func code() -> (name: String, value: String) { return (_code == nil ? (name: "Code", value: "") : (name: "Code", value: _code!)) }
	func message() -> (name: String, value: String) { return (_message == nil ? (name: "Message", value: "") : (name: "Message", value: _message!)) }
	func localizedMessage() -> (name: String, value: String) { return (_localizedMessage == nil ? (name: "Localized Message", value: "") : (name: "Localized Message", value: _localizedMessage!)) }
	func messageParameters() -> (name: String, value: [NotificationParameter]?) { return (_messageParameters == nil ? (name: "Message Parameters", value: nil) : (name: "Message Parameters", value: _messageParameters!)) }
}

struct NotificationParameter : CustomStringConvertible
{
	fileprivate let _id: String?
	fileprivate let _value: String?
	
	var description: String { return "Notification Parameter" }
	
	init(id: String?, value: String?)
	{
		_id = id
		_value = value
	}
	
	func id() -> (name: String, value: String) { return (_id == nil ? (name: "Id", value: "") : (name: "Id", value: _id!)) }
	func value() -> (name: String, value: String) { return (_value == nil ? (name: "Value", value: "") : (name: "Value", value: _value!)) }
}

struct Localization : CustomStringConvertible
{
	fileprivate let _languageCode: String
	fileprivate let _localeCode: String?
	
	var description: String { return "\(languageCode())\(localeCode())" }
	
	init(languageCode: String, localeCode: String?)
	{
		_languageCode = languageCode
		_localeCode = localeCode
	}
	
	func languageCode() -> String { return "<LanguageCode>\(_languageCode)</LanguageCode>" }
	func localeCode() -> String { return (_localeCode == nil ? "" : "<LocaleCode>\(_localeCode!)</LocaleCode>") }
}
