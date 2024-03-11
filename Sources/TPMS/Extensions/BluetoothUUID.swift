//
//  BluetoothUUID.swift
//
//
//  Created by Alsey Coleman Miller on 3/11/24.
//

import Foundation
import Bluetooth

public extension BluetoothUUID {
    
    /// Tire-pressure monitoring system sensor
    static var tpmsService: BluetoothUUID {
        .bit16(0xFBB0)
    }
}
