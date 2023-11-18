
import SwiftUI

struct ContentView: View {
    var difficulty: Difficulty
    @State private var sudokuBoard: [[Int]] = [
        [5, 3, 0, 0, 7, 0, 0, 0, 9],
        [6, 0, 0, 4, 2, 6, 1, 3, 0],
        [0, 9, 8, 0, 0, 0, 0, 6, 0],
        [8, 0, 0, 0, 6, 0, 0, 0, 3],
        [4, 0, 0, 8, 0, 3, 0, 0, 1],
        [7, 0, 0, 0, 2, 0, 0, 0, 6],
        [0, 6, 0, 0, 0, 0, 2, 8, 0],
        [0, 0, 0, 4, 1, 9, 0, 0, 5],
        [0, 0, 0, 0, 8, 0, 0, 7, 9]
    ]

    var body: some View {
        VStack {
            Spacer()
            ForEach(0..<9) { row in
                HStack {
                    ForEach(0..<9) { column in
                        SudokuCell(value: $sudokuBoard[row][column])
                        if column == 2 || column == 5 {
                            Divider().background(Color.black)
                        }
                    }
                }
                // Eğer satır 2 veya 5 ise yatay çizgi ekle
                if row == 2 || row == 5 {
                    Divider().background(Color.black)
                }
            }
            Spacer()
            HStack {
                Button("Solve Sudoku") {
                    self.solveSudoku()
                }
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                
                Button("Refresh Sudoku") {
                    self.refreshSudoku()
                }
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
            }
            
        }
        
    }

    func solveSudoku() {
        let solver = SudokuSolver(board: sudokuBoard)
        if solver.solve() {
            // If the solver finds a solution, update the UI with the solved values
            sudokuBoard = solver.getBoard()
        } else {
            // Handle the case where no solution is found
            print("No solution found.")
        }
    }
    
    func refreshSudoku() {
           // Burada farklı bir sudoku yükleyebilirsiniz. İstediğiniz logic'i ekleyin.
           // Örneğin, farklı bir zorluk seviyesine sahip yeni bir sudoku oluşturabilir veya
           // mevcut sudokuBoard'u temizleyerek başka bir sudoku yükleyebilirsiniz.
       }
}

struct SudokuCell: View {
    @Binding var value: Int

    var body: some View {
        TextField("", value: $value, formatter: NumberFormatter())
            .textFieldStyle(SudokuTextFieldStyle())
    }
}

struct SudokuTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .frame(width: 33, height: 33)
            .border(Color.black, width: 0.3)
            .multilineTextAlignment(.center)
            .foregroundColor(.blue)
            .font(.headline).bold()
            .cornerRadius(2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(difficulty: Difficulty.easy)
    }
}
