//
//  TPMSAdvertisementRow.swift
//  
//
//  Created by Alsey Coleman Miller on 4/12/23.
//

import Foundation
import SwiftUI
import Bluetooth
import TPMS

struct TPMSAdvertisementRow: View {
    
    @EnvironmentObject
    private var store: AccessoryManager
    
    let advertisement: TirePressureSensor
    
    var body: some View {
        StateView(
            advertisement: advertisement
        )
    }
}

internal extension TPMSAdvertisementRow {
    
    struct StateView: View {
        
        let advertisement: TirePressureSensor
                
        var body: some View {
            HStack {
                // icon
                VStack {
                    Text(verbatim: Int(advertisement.pressure.poundPerSquareInch).description)
                    Text("PSI")
                }
                .frame(width: 60)
                
                // Text
                VStack(alignment: .leading) {
                    Text(verbatim: advertisement.address.rawValue)
                        .font(.title3)
                    HStack {
                        Text(verbatim: advertisement.pressure.description)
                        Text(verbatim: advertisement.temperature.description)
                        Text(verbatim: advertisement.batteryLevel.description)
                    }
                    .foregroundColor(.gray)
                    .font(.subheadline)
                }
            }
            
        }
    }
}

// MARK: - Preview

#if DEBUG
struct TPMSAdvertisementRow_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            List {
                EmptyView()
            }
        }
    }
}
#endif
