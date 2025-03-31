//
//  TimerView.swift
//  stepCounter
//
//  Created by Luis Martinez on 31/03/2025.
//

import SwiftUI

struct TimerView: View {
    @StateObject private var viewModel = CountdownTimerViewModel()
    @State private var inputTime: String = "60"

    var body: some View {
        VStack {
            Text(formatTime(viewModel.remainingTime))
                .font(.largeTitle)
                .padding()

            HStack {
                Button("Iniciar") {
                    viewModel.start()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button("Pausar") {
                    viewModel.pause()
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button("Reiniciar") {
                    if let newTime = TimeInterval(inputTime) {
                        viewModel.reset(to: newTime)
                    }
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

            TextField("Tiempo en segundos", text: $inputTime)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding()
        }
        .navigationTitle("Temporizador")
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

