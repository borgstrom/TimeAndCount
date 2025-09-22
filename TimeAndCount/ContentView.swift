//
//  ContentView.swift
//  TimeAndCount
//
//  Created by Evan Borgstrom on 9/19/25.
//

import Combine
import SwiftUI
import AudioToolbox

struct ContentView: View {
    @AppStorage("hours") var hours: Int = 0
    @AppStorage("minutes") var minutes: Int = 0
    @AppStorage("seconds") var seconds: Int = 0
    @AppStorage("countTo") var countTo: Int = 0

    @State private var cancellable: Cancellable?
    @State private var duration = Duration.zero
    @State private var elapsed = Duration.zero
    @State private var startTime = Date()
    
    @State private var currentCount: Int = 1

    var body: some View {
        VStack {
            Text("Time and Count")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            if !isRunning {
                DurationPicker(hours: $hours, minutes: $minutes, seconds: $seconds)
                CountPicker(countTo: $countTo)
                HStack {
                    CircleButton(label: "Start", systemImage: "play.circle.fill", color: .green) {
                        startTimer()
                    }
                }
            }
            else {
                // isRunning
                ZStack {
                    CircleProgressView(
                        progress: elapsed / duration,
                        lineWidth: 10
                    )
                    
                    VStack {
                        Text(
                            duration - elapsed,
                            format: .time(pattern: .minuteSecond(padMinuteToLength: 2))
                        )
                        .font(.system(size: 60)).monospacedDigit()
                        
                        Text(currentCount, format: .number)
                            .font(.system(size: 30)).monospacedDigit()
                            .fontWeight(.bold)
                            .padding(.top)
                    }
                }.padding()
                
                HStack {
                    Spacer()
                    CircleButton(label: "Stop", systemImage: "stop.circle.fill", color: .red) {
                        stopTimer()
                    }
                    Spacer()
                    CircleButton(label: "Repeat", systemImage: "repeat.circle.fill", color: .gray) {
                        repeatTimer()
                    }.disabled(!isFinished)
                    Spacer()
                }
            }
            Spacer()
        }
        .padding()
    }

    private var isRunning: Bool {
        cancellable != nil
    }

    private var isFinished: Bool {
        cancellable != nil && elapsed >= duration
    }
    
    private func repeatTimer() {
        currentCount += 1
        if countTo > 0 && currentCount > countTo {
            currentCount = 1
        }
        startTimer()
    }

    private func startTimer() {
        startTime = Date()
        duration = .seconds(seconds + (minutes * 60) + (hours * 3600))
        
        cancellable = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
            .sink { t in
                elapsed = .seconds(t.timeIntervalSince(startTime))
                if elapsed >= duration {
                    cancellable?.cancel()

                    // TODO: make this better
                    // We should not hard code an ID here and ideally the
                    // user should be able to select the sound they want
                    AudioServicesPlayAlertSound(1013)
                }
            }
    }
    private func stopTimer() {
        cancellable?.cancel()
        cancellable = nil
        
        currentCount = 1
    }
}

#Preview {
    ContentView()
}
