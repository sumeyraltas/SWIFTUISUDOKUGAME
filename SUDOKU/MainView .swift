//
//  MainView .swift
//  SUDOKU
//
//  Created by Sumeyra Altas on 18.11.2023.
//

import SwiftUI

struct MainView: View {
    @State private var selectedDifficulty: Difficulty?

    var body: some View {
    
        NavigationView {
            VStack {
                Spacer()
                Text("Sudoku Solver")
                    .font(.largeTitle)
                    .padding().bold()
                
                Text("Select your level!")
                    .font(.title)
                    .padding()
                
                Spacer()
                NavigationLink(destination:  ContentView(difficulty: Difficulty.easy, selectedDifficulty: .constant(Difficulty.easy))) {
                    DifficultyButton(difficulty: .easy)
                        .background(Color.green)
                        .cornerRadius(25)
                }
                .padding(10)

                NavigationLink(destination:  ContentView(difficulty: Difficulty.medium, selectedDifficulty: .constant(Difficulty.medium))) {
                    DifficultyButton(difficulty: .medium)
                        .background(Color.orange)
                        .cornerRadius(25)
                }
                .padding(10)

                NavigationLink(destination: ContentView(difficulty: Difficulty.hard, selectedDifficulty: .constant(Difficulty.hard))) {
                    DifficultyButton(difficulty: .hard)
                        .background(Color.red)
                        .cornerRadius(25)
                }
                .padding(10)
                Spacer()
            }
            .onChange(of: selectedDifficulty) { newValue in
                // This will be called whenever the selected difficulty changes
                print("Selected difficulty: \(newValue?.rawValue ?? "None")")
            }
        }
    }
}
struct DifficultyButton: View {
    var difficulty: Difficulty

    var body: some View {
        Text(difficulty.rawValue)
            .font(.title)
            .foregroundColor(.white)
            .padding()
        
    }
}

enum Difficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
