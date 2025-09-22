//
//  CircleButton.swift
//  TimeAndCount
//
//  Created by Evan Borgstrom on 9/20/25.
//

import SwiftUI

// CircleButton
struct CircleButton: View {
    let label: String
    let systemImage: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Label(label, systemImage: systemImage)
                .font(.system(size: 80))
                .symbolRenderingMode(.hierarchical)
                .labelStyle(.iconOnly)
                .tint(color)
//            Text(label)
//                .fontWeight(.bold)
//                .frame(width: 80, height: 80)
//                .foregroundColor(color)
//                .background(color.opacity(0.5))
//                .clipShape(Circle())
        }
    }
}

#Preview {
    HStack {
        CircleButton(label: "Start", systemImage: "play.circle.fill", color: .green) {
        }
        CircleButton(label: "Stop", systemImage: "stop.circle.fill", color: .red) {
        }
        CircleButton(label: "Repeat", systemImage: "repeat.circle.fill", color: .gray) {}
//        CircleButton(text: "■", color: .red) {
//        }
//        CircleButton(text: "↻", color: .gray) {
//        }
    }
}
