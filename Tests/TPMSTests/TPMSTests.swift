import Foundation
import XCTest
import Bluetooth
#if canImport(BluetoothGAP)
import BluetoothGAP
#endif
import GATT
@testable import TPMS

final class TPMSTests: XCTestCase {
    
    
    func testTPMS4() throws {
        
        // TPMS4_42A288
        // 83:EA:CA:42:A2:88
        // 16 Bit UUIDs: 0XFBB0
        let data: LowEnergyAdvertisingData = [0x02, 0x01, 0x05, 0x03, 0x03, 0xB0, 0xFB, 0x13, 0xFF, 0x00, 0x01, 0x83, 0xEA, 0xCA, 0x42, 0xA2, 0x88, 0xA8, 0x10, 0x03, 0x00, 0x33, 0x06, 0x00, 0x00, 0x62, 0x00]
        
        XCTAssertEqual(data.serviceUUIDs, [.bit16(0xFBB0)])
        XCTAssertEqual(data.manufacturerData?.companyIdentifier, .tomtomInternational)
        XCTAssertEqual(data.manufacturerData?.additionalData.count, 16)
        
        guard let sensor = TirePressureSensor(data) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(sensor.address.rawValue, "83:EA:CA:42:A2:88")
    }
}
