
import SwiftUI

struct ContentView: View {
    var difficulty: Difficulty
    @Binding var selectedDifficulty: Difficulty
    @State private var sudokuBoard = SudokuBoard()
    @State private var isDifficultyPickerPresented = false
    @State private var showAlert = false

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
            }.padding(150)
                HStack {
                    Button("Solve Sudoku") {
                        self.solveSudoku()
                    }
                    .controlSize(.large)
                    .buttonStyle(.borderedProminent)
                    
                    Button("Refresh Sudoku") {
                            self.isDifficultyPickerPresented.toggle()
                    }
                    .controlSize(.large)
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $isDifficultyPickerPresented) {
                                        DifficultyPicker(selectedDifficulty: $selectedDifficulty, onDismiss: updateBoard)
                                    }
                }
        }
        .onAppear {
            updateBoard() // Initial board update
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("No Solution Found"), message: Text("The Sudoku puzzle has no solution."), dismissButton: .default(Text("OK")))
        }
    }

    func updateBoard() {
        sudokuBoard.board = SudokuBoard().getRandomBoard(difficulty: selectedDifficulty)
    }

    func solveSudoku() {
        let solver = SudokuSolver(board: sudokuBoard.board)
        if solver.solve() {
            sudokuBoard.board = solver.getBoard()
        } else {
            showAlert = true
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
        ContentView(difficulty: Difficulty.easy, selectedDifficulty: .constant(Difficulty.easy))
    }
}
