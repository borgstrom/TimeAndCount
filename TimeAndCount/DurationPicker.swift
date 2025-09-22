//
//  DurationPicker.swift
//  TimeAndCount
//
//  Created by Evan Borgstrom on 9/20/25.
//

import SwiftUI

struct DurationPicker: View {
//    @State var hours: Int = 0
//    @State var minutes: Int = 0
//    @State var seconds: Int = 0
    @Binding var hours: Int
    @Binding var minutes: Int
    @Binding var seconds: Int
    
    var body: some View {
        HStack {
            Picker("Hours", selection: $hours) {
                ForEach(0 ... 23, id: \.self) { hours in
                    Text("\(hours)")
                }
            }
            .pickerStyle(.wheel)
            Text("Hours")
                .font(.subheadline)

            Picker("Minutes", selection: $minutes) {
                ForEach(0 ... 59, id: \.self) { minutes in
                    Text("\(minutes)")
                }
            }
            .pickerStyle(.wheel)
            Text("Mins")
                .font(.subheadline)

            Picker("Seconds", selection: $seconds) {
                ForEach(0 ... 59, id: \.self) { num in
                    Text("\(num)")
                }
            }
            .pickerStyle(.wheel)
            Text("Secs")
                .font(.subheadline)
        }
    }
}

#Preview {
    @Previewable @State var hours: Int = 0
    @Previewable @State var minutes: Int = 0
    @Previewable @State var seconds: Int = 0
    DurationPicker(hours: $hours, minutes: $minutes, seconds: $seconds)
        .padding()
}
