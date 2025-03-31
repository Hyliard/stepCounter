//
//  AlarmViewModel.swift
//  stepCounter
//
//  Created by Luis Martinez on 31/03/2025.
//

import Foundation

class AlarmViewModel: ObservableObject {
    @Published var selectedTime = Date()

    func scheduleAlarm() {
        NotificationManager.shared.scheduleNotification(
            at: selectedTime,
            with: "Alarma Activada",
            body: "¡Es hora!"
        )
    }
}

