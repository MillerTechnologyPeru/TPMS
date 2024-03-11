import Foundation
import Bluetooth
import GATT

/// Tire-pressure monitoring system sensor
public struct TirePressureSensor: Equatable, Hashable, Codable, Sendable {
    
    public static var service: BluetoothUUID { .tpmsService }
    
    public static var companyIdentifier: CompanyIdentifier { .tomtomInternational }
    
    public let address: BluetoothAddress
        
    public let pressure: Pressure
    
    public let temperature: Temperature
    
    public let batteryLevel: BatteryLevel
    
    
}

// MARK: - Identifiable

extension TirePressureSensor: Identifiable {
    
    public var id: BluetoothAddress {
        address
    }
}

// MARK: - Advertisement

public extension TirePressureSensor {
    
    init?<T: AdvertisementData>(_ advertisement: T) {
        guard advertisement.serviceUUIDs == [Self.service],
              let manufacturerData = advertisement.manufacturerData,
              manufacturerData.companyIdentifier == Self.companyIdentifier,
              manufacturerData.additionalData.count == 16,
              let batteryLevel = BatteryLevel(rawValue: manufacturerData.additionalData[14]) else {
            return nil
        }
        self.address = BluetoothAddress(
            bigEndian:
                BluetoothAddress(
                    bytes: (
                        manufacturerData.additionalData[0],
                        manufacturerData.additionalData[1],
                        manufacturerData.additionalData[2],
                        manufacturerData.additionalData[3],
                        manufacturerData.additionalData[4],
                        manufacturerData.additionalData[5]
                    )
                )
        )
        self.pressure = Pressure(rawValue: UInt32(littleEndian: UInt32(bytes: (manufacturerData.additionalData[6], manufacturerData.additionalData[7], manufacturerData.additionalData[8], manufacturerData.additionalData[9]))))
        self.temperature = Temperature(rawValue: UInt32(littleEndian: UInt32(bytes: (manufacturerData.additionalData[10], manufacturerData.additionalData[11], manufacturerData.additionalData[12], manufacturerData.additionalData[13]))))
        self.batteryLevel = batteryLevel
    }
}
