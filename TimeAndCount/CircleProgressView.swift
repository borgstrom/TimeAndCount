//
//  CircleProgressView.swift
//  TimeAndCount
//
//  Created by Evan Borgstrom on 9/21/25.
//

import SwiftUI

struct CircleProgressView: View {
    
    var progress: Double
    var lineWidth: CGFloat
    var color: Color = .orange
    
    var body: some View {
        
        ZStack {
            Circle().stroke(
                .black.opacity(0.5),
                lineWidth: lineWidth
            )

            Circle()
                .trim(from: 0, to: min(progress, 1.0))
                .stroke(
                    color.gradient,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
            .rotationEffect(.degrees(-90))
            .animation(.easeOut(duration: 0.25), value: progress)
        }
    }
}

#Preview {
    CircleProgressView(progress: 0.75, lineWidth: 10)
        .padding()
}
