//
//  StopwatchView.swift
//  stepCounter
//
//  Created by Luis Martinez on 31/03/2025.
//

import SwiftUI

struct StopwatchView: View {
    @StateObject private var viewModel = TimerViewModel()

    var body: some View {
        VStack {
            Text(formatTime(viewModel.elapsedTime))
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
                    viewModel.reset()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .navigationTitle("Cronómetro")
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let milliseconds = Int((time * 10).truncatingRemainder(dividingBy: 10))
        return String(format: "%02d:%02d.%d", minutes, seconds, milliseconds)
    }
}

