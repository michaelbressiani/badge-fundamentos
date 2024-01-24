//
//  SecureStorageManager.swift
//  Pan CredCard
//
//  Created by Michael Bressiani on 22/01/24.
//

import Foundation
import Security

class SecureStorageManager {
    
    private let cardKeychainService = "PanCredCard"
    private let cardKeychainAccount = ""
    
    func saveCardToKeychain(card: Card, idCard: Int) {
        do {
            let cardData = try JSONEncoder().encode(card)
            
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: cardKeychainService,
                kSecAttrAccount as String: cardKeychainAccount + String(idCard),
                kSecValueData as String: cardData
            ]
            
            let status = SecItemAdd(query as CFDictionary, nil)
            
            if status == errSecSuccess {
                print("Armazenamento do cartão no Keychain realizado com sucesso.")
            } else if status == errSecDuplicateItem {
                let updateQuery: [String: Any] = [
                    kSecValueData as String: cardData
                ]
                
                let updateStatus = SecItemUpdate(query as CFDictionary, updateQuery as CFDictionary)
                
                if updateStatus == errSecSuccess {
                    print("Sucesso na atualização do cartão no Keychain.")
                }
            } else {
                print("Erro ao armazenar o cartão no Keychain. Código do erro: \(status)")
            }
        } catch {
            print("Erro ao codificar o cartão: \(error)")
        }
    }
}
