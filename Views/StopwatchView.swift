//
//  StopwatchView.swift
//  stepCounter
//
//  Created by Luis Martinez on 31/03/2025.
//

import SwiftUI

struct StopwatchView: View {
    @StateObject private var viewModel = TimerViewModel()
    @State private var buttonScale: CGFloat = 1.0
    

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.1, blue: 0.2), Color(red: 0.2,green: 0.2, blue: 0.4)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                ZStack {
                    Circle()
                        .stroke(Color .white.opacity(0.2), lineWidth: 10)
                        .frame(width: 280, height: 280)
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(viewModel.elapsedTime.truncatingRemainder(dividingBy: 60) / 60))
                        .stroke(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                                           startPoint: .top, endPoint: .bottom),
                                            style: StrokeStyle(lineWidth: 10, lineCap: .round))
                                .frame(width:280, height: 280)
                                .rotationEffect(.degrees(-90))
                                .animation(.linear(duration: 0.1), value: viewModel.elapsedTime)
                    
                    Text(formatTime(viewModel.elapsedTime))
                        .font(.system(size: 48, weight: .bold, design: .monospaced))
                                                .foregroundColor(.white)
                                                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                }
                
                HStack(spacing: 20){
                    if viewModel.isRunning {
                        ActionButton(icon: "pause.fill", color: .orange) {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                                buttonScale = 0.8
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    buttonScale = 1.0
                                }
                            }
                            viewModel.pause()
                        }
                        .scaleEffect(buttonScale)
                    } else {
                        ActionButton(icon: "play.fill", color:.green) {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                                buttonScale = 0.8
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    buttonScale = 1.0
                                }
                            }
                            viewModel.start()
                        }
                        .scaleEffect(buttonScale)
                    }
                    
                    ActionButton(icon: "arrow.clockwise", color: .red) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                            buttonScale = 0.8
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                buttonScale = 1.0
                            }
                        }
                        viewModel.reset()
                    }
                    .scaleEffect(buttonScale)
                }
            }
            .padding()
        }
        .navigationTitle("Cronometro")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Cronometro")
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
        
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let milliseconds = Int((time * 100).truncatingRemainder(dividingBy: 100))
        return String(format: "%02d:%02d.%d", minutes, seconds, milliseconds)
    }
}

struct ActionButton: View {
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
            Button(action: action) {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 70, height: 70)
                    .background(color)
                    .clipShape(Circle())
                    .shadow(color: color.opacity(0.5), radius: 10, x: 0, y: 5)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.2), lineWidth: 2)
                    )
            }
        }
    }
