//
//  CountPicker.swift
//  TimeAndCount
//
//  Created by Evan Borgstrom on 9/21/25.
//

import SwiftUI

struct CountPicker: View {
    @Binding var countTo: Int
    
    var body: some View {
        HStack {
            Picker("Count to", selection: $countTo) {
                ForEach(0 ... 99, id: \.self) { num in
                    if num == 0 {
                        Text("∞")
                    }
                    else {
                        Text("\(num)")
                    }
                }
            }
            .pickerStyle(.wheel)
            Text("Count to")
        }
    }
}

#Preview {
    @Previewable @State var countTo: Int = 0

    CountPicker(countTo: $countTo)
}
