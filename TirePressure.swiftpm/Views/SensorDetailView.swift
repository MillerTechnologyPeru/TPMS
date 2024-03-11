//
//  TPMSDetailView.swift
//  
//
//  Created by Alsey Coleman Miller on 4/12/23.
//

import Foundation
import SwiftUI
import Bluetooth
import GATT
import TPMS

struct TirePressureSensorDetailView: View {
    
    let id: TirePressureSensor.ID
    
    @EnvironmentObject
    private var store: AccessoryManager
    
    init(
        id: TirePressureSensor.ID
    ) {
        self.id = id
    }
    
    var body: some View {
        VStack {
            if let advertisement = store.peripherals.first(where: { $0.value.id == self.id })?.value {
                StateView(
                    sensor: advertisement
                )
            } else {
                Text(verbatim: id.description)
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
        .navigationTitle("\(id.description)")
    }
}

extension TirePressureSensorDetailView {
    
    struct StateView: View {
        
        let sensor: TirePressureSensor
                
        var body: some View {
            List {
                VStack {
                    Text("Pressure")
                    Text(verbatim: sensor.pressure.description)
                }
                
                VStack {
                    Text("Temperature")
                    Text(verbatim: sensor.temperature.description)
                }
                
                VStack {
                    Text("Battery Level")
                    Text(verbatim: sensor.batteryLevel.description)
                }
            }
        }
    }
}

// MARK: - Preview


