import Foundation
import XCTest
import Bluetooth
#if canImport(BluetoothGAP)
import BluetoothGAP
#endif
import GATT
@testable import TPMS

final class TPMSTests: XCTestCase {
    
    func testTPMS1() {
        
        // 80:EA:CA:12:BA:74
        let data: LowEnergyAdvertisingData = [0x02, 0x01, 0x05, 0x03, 0x03, 0xB0, 0xFB, 0x13, 0xFF, 0x00, 0x01, 0x80, 0xEA, 0xCA, 0x12, 0xBA, 0x74, 0xC6, 0x36, 0x03, 0x00, 0xCE, 0x06, 0x00, 0x00, 0x62, 0x00]
        
        XCTAssertEqual(data.serviceUUIDs, [.bit16(0xFBB0)])
        XCTAssertEqual(data.manufacturerData?.companyIdentifier, .tomtomInternational)
        XCTAssertEqual(data.manufacturerData?.additionalData.count, 16)
        
        guard let sensor = TirePressureSensor(data) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(sensor.address.rawValue, "80:EA:CA:12:BA:74")
        XCTAssertEqual(sensor.pressure, 210.630)
        XCTAssertEqual(sensor.pressure.rawValue, 210630)
        XCTAssertEqual(sensor.pressure.poundPerSquareInch, 30.549286704685876)
        XCTAssertEqual(sensor.temperature, 17.42)
        XCTAssertEqual(sensor.temperature.rawValue, 1742)
        XCTAssertEqual(sensor.batteryLevel, 98)
    }
    
    func testTPMS2() {
        
        // TPMS2_22AF9B
        // 81:EA:CA:22:AF:9B
        // 16 Bit UUIDs: 0XFBB0
        let data: LowEnergyAdvertisingData = [0x02, 0x01, 0x05, 0x03, 0x03, 0xB0, 0xFB, 0x13, 0xFF, 0x00, 0x01, 0x81, 0xEA, 0xCA, 0x22, 0xAF, 0x9B, 0x97, 0x16, 0x03, 0x00, 0x47, 0x06, 0x00, 0x00, 0x62, 0x00]
        
        XCTAssertEqual(data.serviceUUIDs, [.bit16(0xFBB0)])
        XCTAssertEqual(data.manufacturerData?.companyIdentifier, .tomtomInternational)
        XCTAssertEqual(data.manufacturerData?.additionalData.count, 16)
        
        guard let sensor = TirePressureSensor(data) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(sensor.address.rawValue, "81:EA:CA:22:AF:9B")
        XCTAssertEqual(sensor.pressure, 202.391)
        XCTAssertEqual(sensor.pressure.rawValue, 202391)
        XCTAssertEqual(sensor.pressure.poundPerSquareInch, 29.35432125266144)
        XCTAssertEqual(sensor.temperature, 16.07)
        XCTAssertEqual(sensor.temperature.rawValue, 1607)
        XCTAssertEqual(sensor.batteryLevel, 98)
    }
    
    func testTPMS3() throws {
        
        // 82:EA:CA:32:A7:0C
        let data: LowEnergyAdvertisingData = [0x02, 0x01, 0x05, 0x03, 0x03, 0xB0, 0xFB, 0x13, 0xFF, 0x00, 0x01, 0x82, 0xEA, 0xCA, 0x32, 0xA7, 0x0C, 0x64, 0x23, 0x03, 0x00, 0xB6, 0x06, 0x00, 0x00, 0x62, 0x00]
        
        XCTAssertEqual(data.serviceUUIDs, [.bit16(0xFBB0)])
        XCTAssertEqual(data.manufacturerData?.companyIdentifier, .tomtomInternational)
        XCTAssertEqual(data.manufacturerData?.additionalData.count, 16)
        
        guard let sensor = TirePressureSensor(data) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(sensor.address.rawValue, "82:EA:CA:32:A7:0C")
        XCTAssertEqual(sensor.pressure, 205.668)
        XCTAssertEqual(sensor.pressure.rawValue, 205668)
        XCTAssertEqual(sensor.pressure.poundPerSquareInch, 29.82960973260853)
        XCTAssertEqual(sensor.temperature, 17.18)
        XCTAssertEqual(sensor.temperature.rawValue, 1718)
        XCTAssertEqual(sensor.batteryLevel, 98)
    }
    
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
        XCTAssertEqual(sensor.pressure, 200.872)
        XCTAssertEqual(sensor.pressure.rawValue, 200872)
        XCTAssertEqual(sensor.pressure.poundPerSquareInch, 29.134009015542237)
        XCTAssertEqual(sensor.temperature, 15.87)
        XCTAssertEqual(sensor.temperature.rawValue, 1587)
        XCTAssertEqual(sensor.batteryLevel, 98)
    }
}
