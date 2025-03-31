//
//  StepCounterViewModel.swift
//  stepCounter
//
//  Created by Luis Martinez on 31/03/2025.
//

import Foundation
import CoreMotion

class StepCounterViewModel: ObservableObject {
    private let pedometer = CMPedometer()
    @Published var stepCount: Int = 0

    func startTracking() {
        guard CMPedometer.isStepCountingAvailable() else { return }

        pedometer.startUpdates(from: Date()) { data, error in
            DispatchQueue.main.async {
                if let data = data {
                    self.stepCount = data.numberOfSteps.intValue
                }
            }
        }
    }

    func stopTracking() {
        pedometer.stopUpdates()
    }
}

