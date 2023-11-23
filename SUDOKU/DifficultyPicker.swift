//
//  DifficultyPicker.swift
//  SUDOKU
//
//  Created by Sumeyra Altas on 23.11.2023.
//

import Foundation
import SwiftUI
struct DifficultyPicker: View {
    @Binding var selectedDifficulty: Difficulty
    var onDismiss: () -> Void

    var body: some View {
        VStack {
            Text("Choose Difficulty Level")
                .font(.headline)
                .padding()

            Picker("Difficulty", selection: $selectedDifficulty) {
                ForEach(Difficulty.allCases, id: \.self) { difficulty in
                    Text(difficulty.rawValue.capitalized)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .padding()

            Button("OK") {
                // Dismiss the sheet and refresh the Sudoku board
                self.dismiss()
            }
            .padding()
        }
    }
    func dismiss() {
          onDismiss()
          UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
      }
}
