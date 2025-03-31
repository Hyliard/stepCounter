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
        NavigationStack {
            ZStack {
                // Fondo degradado
                LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.purple]),
                               startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    // Título
                    Text("Nueva Alarma")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    // Selector de hora con nuevo estilo
                    VStack {
                        Text("Hora seleccionada")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.8))
                        
                        DatePicker("", selection: $viewModel.selectedTime,
                                  displayedComponents: .hourAndMinute)
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(15)
                            .colorScheme(.dark)
                            .accentColor(.yellow)
                    }
                    .padding(.horizontal)
                    
                    // Botón con estilo moderno
                    Button(action: {
                        viewModel.scheduleAlarm()
                    }) {
                        HStack {
                            Image(systemName: "bell.fill")
                            Text("Programar Alarma")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.2), radius: 5, y: 3)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 20)
                    
                    Spacer()
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Configurar Alarma")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                }
            }
            .onAppear {
                NotificationManager.shared.requestPermission()
            }
        
        }
    }
}

