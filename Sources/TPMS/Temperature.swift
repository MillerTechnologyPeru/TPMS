//
//  Temperature.swift
//  
//
//  Created by Alsey Coleman Miller on 3/11/24.
//

import Foundation

public extension TirePressureSensor {
    
    struct Temperature: RawRepresentable, Equatable, Hashable, Codable, Sendable {
                
        public let rawValue: UInt32
        
        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
}

public extension TirePressureSensor.Temperature {
    
    var celsius: Float {
        Float(rawValue) / 100
    }
}

// MARK: - ExpressibleByFloatLiteral

extension TirePressureSensor.Temperature: ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: Float) {
        self.init(rawValue: UInt32(value * 100))
    }
}

// MARK: - CustomStringConvertible

extension TirePressureSensor.Temperature: CustomStringConvertible {
    
    public var description: String {
        return "\(celsius)°C"
    }
}
