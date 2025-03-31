//
//  ContentView.swift
//  stepCounter
//
//  Created by Luis Martinez on 31/03/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: StepCounterView()) {
                    Text("Ir al Contador de Pasos")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                NavigationLink(destination: StopwatchView()) {
                    Text("Ir al Cronómetro")
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                NavigationLink(destination: TimerView()) {
                    Text("Ir al Temporizador")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                NavigationLink(destination: AlarmView()) {
                    Text("Ir a la Alarma")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Inicio")
        }
    }
}
