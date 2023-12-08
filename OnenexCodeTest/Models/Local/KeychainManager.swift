//
//  KeychainManager.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/8/23.
//

import Foundation
import SwiftKeychainWrapper

struct HelperKeys {
    static let USER_TOKEN = "K_USER_TOKEN"
}

class KeychainManager: NSObject {
    static let shared = KeychainManager()
    
     func saveKChainValueString (_ value: String,_ key: String) {
        KeychainWrapper.standard.set(value,forKey: key)
    }
    
     func getKChainValuesString (_ key: String) -> String? {
       return KeychainWrapper.standard.string(forKey: key)
    }
}
