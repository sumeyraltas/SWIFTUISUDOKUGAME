
import SwiftUI

struct ContentView: View {
    var difficulty: Difficulty
    @Binding var selectedDifficulty: Difficulty
    @State private var sudokuBoard = SudokuBoard()
    @State private var isDifficultyPickerPresented = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
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
                    }
                }
            }.padding(125)
                HStack {
                    Button("Finish Sudoku") {
                        self.finishSudoku()
                    }
                    .buttonStyle(.borderedProminent).padding()
                    
                    Button("Solve Sudoku") {
                        self.solveSudoku()
                    }
                    .buttonStyle(.borderedProminent).padding()
                    
                    Button("Refresh Sudoku") {
                            self.isDifficultyPickerPresented.toggle()
                    }
               
                    .buttonStyle(.borderedProminent).padding()
                    .sheet(isPresented: $isDifficultyPickerPresented) {
                                        DifficultyPicker(selectedDifficulty: $selectedDifficulty, onDismiss: updateBoard)
                                    }
                }
        }
        .onAppear {
            updateBoard() // Initial board update
        }
      
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func updateBoard() {
        sudokuBoard.board = SudokuBoard().getRandomBoard(difficulty: selectedDifficulty)
    }
    
    func solveSudoku() {
        let solver = SudokuSolver(board: sudokuBoard.board)
        
        if solver.solve() {
            sudokuBoard.board = solver.getBoard()
            showAlert(title:"Sudoku Finished",message: "You can observe the solved Sudoku!")
        } else {
            showAlert(title:"Sorry!",message: "No Solution Found")
        }
    }
    func finishSudoku() {
        let solver = SudokuSolver(board: sudokuBoard.board)
        let isBoardFullyFilled = sudokuBoard.board.flatMap { $0 }.allSatisfy { $0 != 0 }
        
        if isBoardFullyFilled {
            let userBoard = sudokuBoard.board.map { $0.map { $0 } }
            
            if solver.solve() && userBoard == solver.getBoard() {
                showAlert(title: "Congratulations!", message: "You've successfully completed the Sudoku!")
            } else {
                showAlert(title: "Please Try Again", message: "The Sudoku solution is not correct. Keep trying!")
            }
        } else {
            showAlert(title: "Incomplete Sudoku", message: "Please fill in all cells before finishing.")
        }
    }




    func showAlert(title: String, message: String) {
        showAlert = true
        alertTitle = title
        alertMessage = message
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
        ContentView(difficulty: Difficulty.easy, selectedDifficulty: .constant(Difficulty.easy))
    }
}
