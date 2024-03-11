//
//  BatteryLevel.swift
//  
//
//  Created by Alsey Coleman Miller on 3/11/24.
//

import Foundation

public extension TirePressureSensor {
    
    struct BatteryLevel: RawRepresentable, Equatable, Hashable, Codable, Sendable {
                
        public let rawValue: UInt8
        
        public init?(rawValue: UInt8) {
            guard rawValue <= 100 else {
                return nil
            }
            self.rawValue = rawValue
        }
    }
}

public extension TirePressureSensor.BatteryLevel {
    
    var percentage: Float {
        Float(rawValue)
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension TirePressureSensor.BatteryLevel: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: UInt8) {
        guard let value = TirePressureSensor.BatteryLevel(rawValue: value) else {
            fatalError()
        }
        self = value
    }
}

// MARK: - CustomStringConvertible

extension TirePressureSensor.BatteryLevel: CustomStringConvertible {
    
    public var description: String {
        return "\(rawValue)%"
    }
}
