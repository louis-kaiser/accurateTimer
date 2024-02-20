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
            }
            Button("Stop", action: stopTimer)
        }
    }
    
    private var formattedElapsedTime: String {
        let totalElapsedTime = elapsedTime + timeBeforePause
        let minutes = Int(totalElapsedTime) / 60
        let seconds = Int(totalElapsedTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
        //return String(totalElapsedTime)
    }
    
    private func startTimer() {
        startTime = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            if let startTime = self.startTime {
                self.elapsedTime = -startTime.timeIntervalSinceNow
            }
        }
    }
    
    private func pauseTimer() {
        timer?.invalidate()
        self.startTime = nil
        timeBeforePause += elapsedTime
        elapsedTime = 0.0
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        startTime = nil
        elapsedTime = 0.0
        timeBeforePause = 0.0
    }
    
}

