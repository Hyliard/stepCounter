//
//  CountdownTimerViewModel.swift
//  stepCounter
//
//  Created by Luis Martinez on 31/03/2025.
//

import Foundation
import Combine

class CountdownTimerViewModel: ObservableObject {
    @Published var remainingTime: TimeInterval = 60  // Tiempo por defecto: 60 segundos
    private var timer: Timer?
    private var isRunning = false

    func start() {
        guard !isRunning, remainingTime > 0 else { return }
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            } else {
                self.timer?.invalidate()
                self.isRunning = false
            }
        }
    }

    func pause() {
        timer?.invalidate()
        isRunning = false
    }

    func reset(to seconds: TimeInterval = 60) {
        timer?.invalidate()
        remainingTime = seconds
        isRunning = false
    }
}

