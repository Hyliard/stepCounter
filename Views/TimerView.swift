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
    @State private var showingTimerPicker: Bool = false
    
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30){
                
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 10)
                        .frame(width: 280, height: 280)
                    
                Circle()
                    .trim(from: 0, to: CGFloat(viewModel.progress))
                    .stroke(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing),
                                                style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .frame(width: 280, height: 280)
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut, value: viewModel.progress)
                    
                    Text(formatTime(viewModel.remainingTime))
                        .font(.system(size: 60, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        
                }
                .padding(.top, 40)
                
                
                HStack(spacing: 20) {
                    Button(action : {
                        viewModel.start()
                    }) {
                        Image(systemName: "play.fill")
                    }
                    .font(.title)
                    .padding(20)
                    .foregroundColor(.white)
                    .background(Circle().fill(Color.green))
                    
                    Button(action: {
                        viewModel.pause()
                    }) {
                        Image(systemName: "pause.fill")
                        .font(.title)
                        .padding(20)
                        .background(Circle().fill(Color.orange))
                        .foregroundColor(.white)
                    }
                    
                    
                    Button(action: {
                        if let newTime = TimeInterval(inputTime) {
                            viewModel.reset(to: newTime)
                        }
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.title)
                            .padding(20)
                            .background(Circle().fill(Color.red))
                            .foregroundColor(.white)
                    }
                    
                }
                
                Button(action: {
                    showingTimerPicker.toggle()
                }) {
                    HStack {
                        Image(systemName: "timer")
                        Text("Establecer tiempo")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(0.2)))
                }
                .sheet(isPresented: $showingTimerPicker){
                    timerPickerView()
                }
                
                Spacer()

            }
            .padding()
        }
        .navigationTitle("Temporizador")
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    @ViewBuilder
    private func timerPickerView() -> some View {
        VStack(spacing: 20){
            Text("Establecer tiempo")
                .font(.title2.bold())
                .padding(.top)
            
            TextField("Segundos", text: $inputTime)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button("Aplicar") {
                if let newTime = TimeInterval(inputTime) {
                    viewModel.reset(to: newTime)
                }
                showingTimerPicker = false
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()
            
            Spacer()
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
