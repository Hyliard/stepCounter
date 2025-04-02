//
//  ModernTimerView.swift
//  stepCounter
//
//  Created by Luis Martinez on 02/04/2025.
//

import SwiftUI

struct ModernTimerView: View {
    @StateObject private var viewModel = CountdownTimerViewModel()
    @State private var inputTime: String = "60"
    @State private var buttonScale: CGFloat = 1.0  // Para animación de botones
    
    var body: some View {
        ZStack {
            // Fondo degradado moderno
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]),
                          startPoint: .topLeading,
                          endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                // Display circular del tiempo
                ZStack {
                    // Círculo de fondo
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 15)
                        .frame(width: 250, height: 250)
                    
                    // Círculo de progreso (se reduce con el tiempo)
                    Circle()
                        .trim(from: 0, to: CGFloat(viewModel.remainingTime) / CGFloat(TimeInterval(inputTime) ?? 60))
                        .stroke(LinearGradient(gradient: Gradient(colors: [.white, .blue]),
                                              style: StrokeStyle(lineWidth: 15, lineCap: .round))
                        .frame(width: 250, height: 250)
                        .rotationEffect(.degrees(-90))  // Empieza desde arriba
                    
                    // Texto del tiempo
                    Text(formatTime(viewModel.remainingTime))
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
                
                // Botones de control
                HStack(spacing: 20) {
                    // Botón Iniciar/Pausar
                    Button(action: {
                        withAnimation(.spring()) { buttonScale = 0.9 }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.spring()) { buttonScale = 1.0 }
                        }
                        viewModel.start()
                    }) {
                        Image(systemName: "play.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Circle().fill(Color.green))
                            .shadow(radius: 10)
                    }
                    
                    // Botón Reiniciar
                    Button(action: {
                        withAnimation(.spring()) { buttonScale = 0.9 }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.spring()) { buttonScale = 1.0 }
                        }
                        if let newTime = TimeInterval(inputTime) {
                            viewModel.reset(to: newTime)
                        }
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Circle().fill(Color.red))
                            .shadow(radius: 10)
                    }
                }
                
                // Campo de texto para ingresar tiempo
                TextField("Segundos", text: $inputTime)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 50)
                    .padding(.vertical, 10)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
            }
        }
        .navigationTitle("Temporizador Moderno")
    }
    
    // Función para formatear el tiempo (00:00)
    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
