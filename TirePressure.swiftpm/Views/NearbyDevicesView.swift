//
//  NearbyDevicesView.swift
//  
//
//  Created by Alsey Coleman Miller on 4/12/23.
//

import Foundation
import SwiftUI
import Bluetooth
import GATT
import TPMS

struct NearbyDevicesView: View {
    
    @EnvironmentObject
    var store: AccessoryManager
    
    @State
    private var scanTask: Task<Void, Never>?
    
    var body: some View {
        list
        .navigationTitle(title)
        .navigationBarItems(trailing: scanButton)
        .onAppear {
            scanTask?.cancel()
            scanTask = Task {
                // start scanning after delay
                try? await store.central.wait(for: .poweredOn)
                if store.isScanning == false {
                    toggleScan()
                }
            }
        }
    }
}

private extension NearbyDevicesView {
    
    enum ScanState {
        case bluetoothUnavailable
        case scanning
        case stopScan
    }
    
    struct Item: Equatable, Hashable, Identifiable {
        
        var id: NativePeripheral.ID {
            peripheral.id
        }
        
        let peripheral: NativePeripheral
        
        let advertisement: TirePressureSensor
    }
    
    var items: [Item] {
        store
            .peripherals
            .map { (peripheral, advertisement) in
                Item(
                    peripheral: peripheral,
                    advertisement: advertisement
                )
            }
            .sorted(by: { $0.advertisement.address.rawValue < $1.advertisement.address.rawValue })
    }
    
    var state: ScanState {
        if store.state != .poweredOn {
            return .bluetoothUnavailable
        } else if store.isScanning {
            return .scanning
        } else {
            return .stopScan
        }
    }
    
    var scanButton: some View {
        Button(action: {
            toggleScan()
        }, label: {
            switch state {
            case .bluetoothUnavailable:
                Image(systemName: "exclamationmark.triangle.fill")
                    .symbolRenderingMode(.multicolor)
            case .scanning:
                Image(systemName: "stop.fill")
                    .symbolRenderingMode(.monochrome)
            case .stopScan:
                Image(systemName: "arrow.clockwise")
                    .symbolRenderingMode(.monochrome)
            }
        })
    }
    
    var title: LocalizedStringKey {
        "TPMS"
    }
    
    var list: some View {
        List {
            ForEach(items) { item in
                NavigationLink(destination: {
                    TirePressureSensorDetailView(
                        id: item.advertisement.id
                    )
                }, label: {
                    TPMSAdvertisementRow(
                        advertisement: item.advertisement
                    )
                })
            }
        }
    }
    
    func toggleScan() {
        if store.isScanning {
            store.stopScanning()
        } else {
            self.scanTask?.cancel()
            self.scanTask = Task {
                guard await store.central.state == .poweredOn,
                      store.isScanning == false else {
                    return
                }
                do {
                    try await store.scan()
                }
                catch { store.log("⚠️ Unable to scan. \(error.localizedDescription)") }
            }
        }
    }
}
