//
//  ContentView.swift
//  stepCounter
//
//  Created by Luis Martinez on 31/03/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo degradado profesional
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.1, blue: 0.3),
                                              Color(red: 0.3, green: 0.1, blue: 0.3)]),
                               startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(spacing: 25) {
                    // Título principal
                    Text("Mi Suite de Tiempo")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 30)
                        .shadow(radius: 5)
                    
                    Spacer()
                    
                    // Tarjetas de navegación
                    VStack(spacing: 20) {
                        NavigationCard(
                            destination: StepCounterView(),
                            icon: "figure.walk",
                            title: "Contador de Pasos",
                            color: .blue,
                            accentColor: .white
                        )
                        
                        NavigationCard(
                            destination: StopwatchView(),
                            icon: "stopwatch",
                            title: "Cronómetro",
                            color: .purple,
                            accentColor: .white
                        )
                        
                        NavigationCard(
                            destination: TimerView(),
                            icon: "timer",
                            title: "Temporizador",
                            color: .orange,
                            accentColor: .white
                        )
                        
                        NavigationCard(
                            destination: AlarmView(),
                            icon: "alarm",
                            title: "Alarma",
                            color: .red,
                            accentColor: .white
                        )
                    }
                    .padding(.horizontal, 25)
                    
                    Spacer()
                    
                    // Pie de página
                    Text("Selecciona una función")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.bottom, 20)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Inicio")
                        .font(.title3.weight(.bold))
                        .foregroundColor(.white)
                }
            }
        }
    }
}

// Componente reutilizable para las tarjetas
struct NavigationCard<Destination: View>: View {
    let destination: Destination
    let icon: String
    let title: String
    let color: Color
    let accentColor: Color
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(accentColor)
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(accentColor)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(accentColor.opacity(0.7))
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(12)
            .shadow(color: color.opacity(0.4), radius: 8, y: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(accentColor.opacity(0.2), lineWidth: 1)
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// Efecto al presionar botones
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
