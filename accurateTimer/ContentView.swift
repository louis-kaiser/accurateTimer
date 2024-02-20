//
//  ContentView.swift
//  accurateTimer
//
//  Created by Louis Kaiser on 20.02.24.
//

import SwiftUI

struct ContentView: View {
    @State private var startTime: Date?
    @State private var elapsedTime: TimeInterval = 0.0
    @State private var timeBeforePause: TimeInterval = 0.0
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            Text("\(formattedElapsedTime)")
                .font(.largeTitle)
                .padding()
            
            if startTime == nil {
                Button("Start", action: startTimer)
            } else {
                Button("Pause", action: pauseTimer)
                Button("Stop", action: stopTimer)
            }
        }
    }
    
    private var formattedElapsedTime: String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func startTimer() {
        startTime = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            if let startTime = self.startTime {
                self.elapsedTime = (-startTime.timeIntervalSinceNow + self.timeBeforePause)
            }
        }
    }
    
    private func pauseTimer() {
        if let startTime = self.startTime {
            self.timeBeforePause = (-startTime.timeIntervalSinceNow + self.timeBeforePause)
            timer?.invalidate()
            self.startTime = nil
            elapsedTime = timeBeforePause
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        startTime = nil
        elapsedTime = 0.0
        timeBeforePause = 0.0
    }
    
}
