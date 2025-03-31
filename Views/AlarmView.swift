//
//  AlarmView.swift
//  stepCounter
//
//  Created by Luis Martinez on 31/03/2025.
//

import SwiftUI

struct AlarmView: View {
    @StateObject private var viewModel = AlarmViewModel()

    var body: some View {
        VStack {
            DatePicker("Selecciona una hora", selection: $viewModel.selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .padding()

            Button("Programar Alarma") {
                viewModel.scheduleAlarm()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .navigationTitle("Alarma")
        .onAppear {
            NotificationManager.shared.requestPermission()
        }
    }
}

