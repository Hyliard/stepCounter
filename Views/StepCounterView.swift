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
        ZStack {
            // Fondo degradado
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.5, blue: 0.3),
                                                     Color(red: 0.1, green: 0.3, blue: 0.4)]),
                          startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Header
                VStack {
                    Text("CONTADOR DE PASOS")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white.opacity(0.7))
                        .tracking(2)
                    
                    Text("\(viewModel.stepCount)")
                        .font(.system(size: 72, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .contentTransition(.numericText())
                    
                    Text("pasos")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.top, 40)
                
                // Indicador circular
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.2), lineWidth: 20)
                        .frame(width: 250, height: 250)
                    
                    Circle()
                        .trim(from: 0, to: min(CGFloat(viewModel.stepCount) / 10000, 1))
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]),
                                              startPoint: .topLeading, endPoint: .bottomTrailing),
                                style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .frame(width: 250, height: 250)
                        .rotationEffect(.degrees(-90))
                        .animation(.spring(response: 0.6, dampingFraction: 1), value: viewModel.stepCount)
                    
                    Image(systemName: "figure.walk")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                }
                .padding(.vertical, 20)
                
                // Botones
                HStack(spacing: 25) {
                    Button(action: { viewModel.startTracking() }) {
                        VStack {
                            Image(systemName: "play.fill")
                                .font(.title)
                            Text("Iniciar")
                                .font(.subheadline)
                        }
                        .frame(width: 100, height: 60)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green.opacity(0.9))
                        .cornerRadius(15)
                        .shadow(color: Color.green.opacity(0.5), radius: 10, y: 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: { viewModel.stopTracking() }) {
                        VStack {
                            Image(systemName: "stop.fill")
                                .font(.title)
                            Text("Detener")
                                .font(.subheadline)
                        }
                        .frame(width: 100, height: 60)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red.opacity(0.9))
                        .cornerRadius(15)
                        .shadow(color: Color.red.opacity(0.5), radius: 10, y: 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.bottom, 30)
                
                // Meta diaria
                Text("Meta: 10,000 pasos")
                    .font(.callout)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.bottom, 20)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Contador de Pasos")
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
    }
}

// Eliminamos la declaración duplicada de ScaleButtonStyle
// y usamos directamente los estilos en los botones

// Vista de previsualización
struct StepCounterView_Previews: PreviewProvider {
    static var previews: some View {
        StepCounterView()
    }
}
