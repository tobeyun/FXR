//
//  KeychainManager.swift
//  FXR
//
//  Created by Tobey Unruh on 4/20/17.
//  Copyright © 2017 Tobey Unruh. All rights reserved.
//

import Foundation

public enum KeychainError: Error {
	case InvalidInput                      // If the value cannot be encoded as NSData
	case OperationUnimplemented         // -4 | errSecUnimplemented
	case InvalidParam                     // -50 | errSecParam
	case MemoryAllocationFailure         // -108 | errSecAllocate
	case TrustResultsUnavailable         // -25291 | errSecNotAvailable
	case AuthFailed                       // -25293 | errSecAuthFailed
	case DuplicateItem                   // -25299 | errSecDuplicateItem
	case ItemNotFound                    // -25300 | errSecItemNotFound
	case ServerInteractionNotAllowed    // -25308 | errSecInteractionNotAllowed
	case DecodeError                      // - 26275 | errSecDecode
	case Unknown(Int)                    // Another error code not defined
}

public struct KeychainManager {
	public static func addData(itemKey:String, itemValue:String) {
		guard let valueData = itemValue.data(using: String.Encoding.utf8) else {
			return //throw KeychainError.InvalidInput
		}
		
		let queryAdd: [String: AnyObject] = [
			kSecClass as String: kSecClassGenericPassword,
			kSecAttrAccount as String: itemKey as AnyObject,
			kSecValueData as String: valueData as AnyObject,
			kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
		]
		let resultCode:OSStatus = SecItemAdd(queryAdd as CFDictionary, nil)
		
		if let err = mapResultCode(result: resultCode) {
			print("\(err)")
		} else {
			print("KeychainManager: Item added successfully")
		}
	}
	
	public static func deleteData(itemKey:String) {
		let queryDelete: [String: AnyObject] = [
			kSecClass as String: kSecClassGenericPassword,
			kSecAttrAccount as String: itemKey as AnyObject
		]
		
		let resultCodeDelete = SecItemDelete(queryDelete as CFDictionary)
		
		if let err = mapResultCode(result: resultCodeDelete) {
			print("\(err)")
		} else {
			print("KeychainManager: Successfully deleted data")
		}
	}
	
	public static func updateData(itemKey:String, itemValue:String) {
		guard let valueData = itemValue.data(using: String.Encoding.utf8) else {
			return //throw KeychainError.InvalidInput
		}
		
		let updateQuery: [String: AnyObject] = [
			kSecClass as String: kSecClassGenericPassword,
			kSecAttrAccount as String: itemKey as AnyObject
		]
		
		let updateAttributes : [String:AnyObject] = [
			kSecValueData as String: valueData as AnyObject
		]
		
		if SecItemCopyMatching(updateQuery as CFDictionary, nil) == noErr {
			let updateResultCode = SecItemUpdate(updateQuery as CFDictionary, updateAttributes as CFDictionary)
			
			if let err = mapResultCode(result: updateResultCode) {
				print("\(err)")
			} else {
				print("KeychainManager: Successfully updated data")
			}
		}
	}
	
	public static func queryData (itemKey:String) -> AnyObject? {
		let queryLoad: [String: AnyObject] = [
			kSecClass as String: kSecClassGenericPassword,
			kSecAttrAccount as String: itemKey as AnyObject,
			kSecReturnData as String: kCFBooleanTrue,
			kSecMatchLimit as String: kSecMatchLimitOne
		]
		var result: AnyObject?
		let resultCodeLoad = withUnsafeMutablePointer(to: &result) {
			SecItemCopyMatching(queryLoad as CFDictionary, UnsafeMutablePointer($0))
		}
		
		if let err = mapResultCode(result: resultCodeLoad) {
			print("\(err)")
		}
		
		guard let resultVal = result as? NSData, let keyValue = NSString(data: resultVal as Data, encoding: String.Encoding.utf8.rawValue) as String? else {
			print("KeychainManager: Error parsing keychain result: \(resultCodeLoad)")
			
			return nil
		}
		return keyValue as AnyObject
	}
}

func mapResultCode(result:OSStatus) -> KeychainError? {
	switch result {
	case 0:
		return nil
	case -4:
		return .OperationUnimplemented
	case -50:
		return .InvalidParam
	case -108:
		return .MemoryAllocationFailure
	case -25291:
		return .TrustResultsUnavailable
	case -25293:
		return .AuthFailed
	case -25299:
		return .DuplicateItem
	case -25300:
		return .ItemNotFound
	case -25308:
		return .ServerInteractionNotAllowed
	case -26275:
		return .DecodeError
	default:
		return .Unknown(result.hashValue)
	}
}
