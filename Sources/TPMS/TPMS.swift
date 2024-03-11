import Foundation
import Bluetooth
import GATT

/// Tire-pressure monitoring system sensor
public struct TirePressureSensor: Equatable, Hashable, Codable, Sendable {
    
    static var service: BluetoothUUID { .tpmsService }
    
    public let address: BluetoothAddress
    
    
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
              let manufacturerData = advertisement.manufacturerData else {
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
    }
}
