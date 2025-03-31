//
//  NotificationManager.swift
//  stepCounter
//
//  Created by Luis Martinez on 31/03/2025.
//

import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error al solicitar permisos: \(error)")
            } else {
                print("Permiso de notificaciones: \(granted ? "Concedido" : "Denegado")")
            }
        }
    }

    func scheduleNotification(at date: Date, with title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error al programar la notificación: \(error)")
            }
        }
    }
}

