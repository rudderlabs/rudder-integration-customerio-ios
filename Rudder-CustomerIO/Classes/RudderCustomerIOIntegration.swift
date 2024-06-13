//
//  RudderCustomerIOIntegration.swift
//  Rudder-CustomerIO
//
//  Created by Satheesh Kannan on 07/06/24.
//

import Foundation
import Rudder
import CioDataPipelines

// MARK: - Rudder ServerConfig Keys
private struct ServerConfigKey {
    static let apiKey = "apiKey"
    static let siteID = "siteID"
    static let autoTrackDeviceAttributes = "autoTrackDeviceAttributes"
    static let dataCenter = "datacenter"
    static let autoTrackScreenViews = "autoTrackScreenViews"
    static let trackApplicationLifecycleEvents = "trackApplicationLifecycleEvents"
    static let logLevel = "logLevel"
    
    private init() {}
}

// MARK: - RudderCustomerIOIntegration

@objcMembers
public class RudderCustomerIOIntegration: NSObject {
    
    // MARK: - Variables
    let config: [AnyHashable : Any]
    let client: RSClient
    let rudderConfig: RSConfig
    
    // MARK: - Initializer
    init(config: [AnyHashable : Any], client: RSClient, rudderConfig: RSConfig) {
        self.config = config
        self.client = client
        self.rudderConfig = rudderConfig
        
        super.init()
        
        self.initializeCustomerIO()
    }
}

// MARK: - Framework Initializer

extension RudderCustomerIOIntegration {
    
    func initializeCustomerIO() {
        guard let config = self.config as? [String: Any] else { return }
        
        if config.isEmpty {
            RSLogger.logError("Destination configuration is empty. Aborting customerio initialization.")
            return
        } else {
            
            guard let apiKey = config[ServerConfigKey.apiKey] as? String, !apiKey.isEmpty else {
                RSLogger.logError("Invalid API key. Aborting customerio initialization.")
                return
            }
            
            guard let siteID = config[ServerConfigKey.siteID] as? String, !siteID.isEmpty else {
                RSLogger.logError("Invalid site id. Aborting customerio initialization.")
                return
            }
                        
            var region = Region.US
            if let configRegion = config[ServerConfigKey.dataCenter] as? String, !configRegion.isEmpty {
                region = configRegion == Region.EU.rawValue ? Region.EU : Region.US
            }
        
            let autoTrackDeviceAttributes = (config[ServerConfigKey.autoTrackDeviceAttributes] as? Bool) ?? true
            
            let cioConfig = SDKConfigBuilder(cdpApiKey: apiKey)
                .migrationSiteId(siteID)
                .region(region)
                .autoTrackDeviceAttributes(autoTrackDeviceAttributes)
                .autoTrackUIKitScreenViews(enabled: self.rudderConfig.recordScreenViews)
                .trackApplicationLifecycleEvents(self.rudderConfig.trackLifecycleEvents)
                .logLevel(self.prepareCustomerIOLogLevel(self.rudderConfig.logLevel))
            
            CustomerIO.initialize(withConfig: cioConfig.build())
        }
    }
    
    func prepareCustomerIOLogLevel(_ level: Int32) -> CioLogLevel {
        return switch level {
        case RSLogLevelVerbose, RSLogLevelDebug:
                .debug
        case RSLogLevelInfo, RSLogLevelWarning:
                .info
        case RSLogLevelError:
                .error
        default:
                .none
        }
    }
}

// MARK: - RSIntegration
extension RudderCustomerIOIntegration: RSIntegration {
    
    enum RSMessageType: String {
        case identify = "identify"
        case screen = "screen"
        case track = "track"
        case group = "group"
        case alias = "alias"
    }
    
    public func dump(_ message: RSMessage) {
        switch message.type {
        case RSMessageType.identify.rawValue:
            self.handleIdentifyMessage(message)
            
        case RSMessageType.track.rawValue:
            self.handleTrackMessage(message)
            
        case RSMessageType.screen.rawValue:
            self.handleScreenMessage(message)
            
        default:
            RSLogger.logWarn("CustomerIOIntegrationFactory: MessageType(\(message.type.capitalized) is not supported")
        }
    }
    
    public func reset() {
        CustomerIO.shared.clearIdentify()
    }
    
    public func flush() {
        RSLogger.logDebug("CustomerIOIntegrationFactory: flush API is not supported.")
    }
}

// MARK: - Event Handlers

extension RudderCustomerIOIntegration {
    func handleIdentifyMessage(_ message: RSMessage) {
        guard let traits = message.context.traits as? [String: Any] else { return }
        
        let userId = message.userId
        let anonymousId = message.anonymousId
        
        if !userId.isEmpty {
            CustomerIO.shared.identify(userId: userId, traits: traits)
        } else if !anonymousId.isEmpty {
            CustomerIO.shared.identify(userId: anonymousId, traits: traits)
        }
    }
    
    func handleTrackMessage(_ message: RSMessage) {
        let event = message.event
        guard !event.isEmpty else { return }
        
        let properties = message.properties
        CustomerIO.shared.track(name: event, properties: properties.isEmpty ? nil : properties)
    }
    
    func handleScreenMessage(_ message: RSMessage) {
        let event = message.event
        guard !event.isEmpty else { return }
        
        let properties = message.properties
        CustomerIO.shared.screen(title: event, properties: properties.isEmpty ? nil : properties)
    }
}
