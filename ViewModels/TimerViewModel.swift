//
//  TimerViewModel.swift
//  stepCounter
//
//  Created by Luis Martinez on 31/03/2025.
//

import Foundation
import Combine

class TimerViewModel: ObservableObject {
    @Published var elapsedTime: TimeInterval = 0
    private var timer: Timer?
    private var startTime: Date?
    @Published var isRunning = false

    func start() {
        guard !isRunning else { return }
        isRunning = true
        startTime = Date() - elapsedTime
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if let start = self.startTime {
                self.elapsedTime = Date().timeIntervalSince(start)
            }
        }
    }

    func pause() {
        timer?.invalidate()
        isRunning = false
    }

    func reset() {
        timer?.invalidate()
        elapsedTime = 0
        isRunning = false
        startTime = nil
    }
}
