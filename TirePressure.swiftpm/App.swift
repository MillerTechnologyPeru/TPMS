import Foundation
import SwiftUI
import CoreBluetooth
import Bluetooth
import GATT
import TPMS

@main
struct TirePressureApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AccessoryManager.shared)
        }
    }
}
