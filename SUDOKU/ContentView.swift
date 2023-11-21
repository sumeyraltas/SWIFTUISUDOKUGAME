
import SwiftUI

struct ContentView: View {
    var difficulty: Difficulty
    @State private var sudokuBoard = SudokuBoard()
   
    var body: some View {
        VStack {
            VStack{
                Spacer()
                ForEach(0..<9) { row in
                    HStack {
                        ForEach(0..<9) { column in
                            SudokuCell(value: $sudokuBoard.board[row][column])
                            if column == 2 || column == 5 {
                                Divider().background(Color.black)
                            }
                        }
                    }
                   
                    if row == 2 || row == 5 {
                        Divider().background(Color.black).frame(width: 380)
                    }   }
            }.padding(150)
   
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
        let solver = SudokuSolver(board: sudokuBoard.board)
        if solver.solve() {
            // If the solver finds a solution, update the UI with the solved values
            sudokuBoard.board = solver.getBoard()
        } else {
            // Handle the case where no solution is found
            print("No solution found.")
        }
    }
    
    func refreshSudoku() {
        switch difficulty {
        case .easy:
            sudokuBoard.board = SudokuBoard().getRandomBoard(difficulty: .easy)
        case .medium:
            sudokuBoard.board = SudokuBoard().getRandomBoard(difficulty: .medium)
        case .hard:
            sudokuBoard.board = SudokuBoard().getRandomBoard(difficulty: .hard)
        }

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
