//
//  ContentView.swift
//  OzoneConverter
//
//  Created by Deepak Kumar Behera on 17/05/25.
//

import SwiftUI

struct ContentView: View {
    let feetToMeter: Double = 0.3048
    let inchesToMeter: Double = 0.0254
    let poundToKg: Double = 2.205
    @State var weight: Double = 0.0
    @State var heightInfeet: Double = 0.0
    @State var heightInInches: Double = 0.0
    @State var weights: [String] = ["Pounds", "Kgs"]
    @State var selectedWeight: String = "Pounds"
    @FocusState var weightIsFocused: Bool
    
    var BMI: Double {
        let heightInMeter = heightInfeet * feetToMeter + heightInInches * inchesToMeter
        guard heightInMeter > 0 else { return 0 }

        let weightInKg = selectedWeight == "Pounds" ? weight / poundToKg : weight
        return weightInKg / (heightInMeter * heightInMeter)
    }
    
    var message: String {
        if BMI < 18.5 {
            "Underweight"
        }else if BMI < 24.9 {
            "Normal weight"
        }else if BMI < 29.9 {
            "Overweight"
        }else {
            "Obesity"
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("BMI Calculator")
                    .font(.title)
                    .fontWeight(.bold)
                    .fontWidth(.standard)
                    .bold()
                    .foregroundStyle(.white)
                    .padding()
                Form {
                    Section {
                        Text("Weight")
                            .font(.title)
                            .foregroundColor(.white)
                        
                        VStack {
                            TextField("Enter Weight", value: $weight, format: .number)
                                .focused($weightIsFocused)
                                .keyboardType(.numberPad)
                                .foregroundColor(.white)
                                .padding(.leading, 10)
                            
                            Spacer()
                            
                            Picker("", selection: $selectedWeight) {
                                ForEach(weights, id: \.self) { weight in
                                    Text(weight)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .listRowBackground(Color.clear)
                    Section {
                        Text("Height")
                            .font(.title)
                            .foregroundStyle(.white)
                        HStack {
                            TextField("Enter the Height in feet", value: $heightInfeet, format: .number)
                                .keyboardType(.numberPad)
                                .foregroundColor(.white)
                                .padding(.leading, 10)
                                .focused($weightIsFocused)
                            
                            Spacer()
                            
                            Text("feet")
                                .foregroundColor(.white)
                                .padding(.trailing, 10)
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        HStack {
                            TextField("Enter the Height in inches", value: $heightInInches, format: .number)
                                .keyboardType(.numberPad)
                                .foregroundColor(.white)
                                .padding(.leading, 10)
                                .focused($weightIsFocused)
                            
                            Spacer()
                            
                            Text("inches")
                                .foregroundColor(.white)
                                .padding(.trailing, 10)
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                    }.listRowBackground(Color.clear)
                }.scrollContentBackground(.hidden)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.1))
                    ).padding(EdgeInsets(top: 30, leading: 15, bottom: 40, trailing: 15))
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .toolbar {
                        if weightIsFocused {
                            Button("Done") {
                                weightIsFocused = false
                            }
                        }
                    }
                Text("BMI: \(BMI, specifier: "%.1f")")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .padding()
                Spacer()
                Text("\(message)")
                    .font(.title)
                    .foregroundStyle(.white)
                Spacer()
                Spacer()
            }.background(LinearGradient(colors: [Color("lightblue"), Color("lightpurple")], startPoint: .leading, endPoint: .trailing))
        }
    }
}

