//
//  RudderCustomerIOFactory.swift
//  Rudder-CustomerIO
//
//  Created by Satheesh Kannan on 07/06/24.
//

import Foundation
import Rudder

// MARK: - RudderCustomerIOFactory
@objcMembers
public class RudderCustomerIOFactory: NSObject, RSIntegrationFactory {
    
    // MARK: - Instance
    public static let instance: RudderCustomerIOFactory = RudderCustomerIOFactory()
    
    // MARK: - Initializer
    public func initiate(_ config: [AnyHashable : Any], client: RSClient, rudderConfig: RSConfig) -> any RSIntegration {
        RSLogger.logDebug("Creating RudderIntegrationFactory")
        
        return RudderCustomerIOIntegration(config: config, client: client, rudderConfig: rudderConfig)
    }
    
    // MARK: - Key
    public func key() -> String {
        return "Customer IO"
    }
}
