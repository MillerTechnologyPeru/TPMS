//
//  Pressure.swift
//
//
//  Created by Alsey Coleman Miller on 3/11/24.
//

import Foundation

public extension TirePressureSensor {
    
    struct Pressure: RawRepresentable, Equatable, Hashable, Codable, Sendable {
                
        public let rawValue: UInt32
        
        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
}

public extension TirePressureSensor.Pressure {
    
    var kilopascal: Float {
        Float(rawValue) / 1000
    }
}

// MARK: - ExpressibleByFloatLiteral

extension TirePressureSensor.Pressure: ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: Float) {
        self.init(rawValue: UInt32(value * 1000))
    }
}

// MARK: - CustomStringConvertible

extension TirePressureSensor.Pressure: CustomStringConvertible {
    
    public var description: String {
        return "\(kilopascal)kPa"
    }
}
