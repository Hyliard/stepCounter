//
//  StepCounterView.swift
//  stepCounter
//
//  Created by Luis Martinez on 31/03/2025.
//

import SwiftUI

struct StepCounterView: View {
    @StateObject private var viewModel = StepCounterViewModel()

    var body: some View {
        VStack {
            Text("Pasos: \(viewModel.stepCount)")
                .font(.largeTitle)
                .padding()

            HStack {
                Button("Iniciar") {
                    viewModel.startTracking()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button("Detener") {
                    viewModel.stopTracking()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
}
