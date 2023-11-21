import Foundation

class SudokuSolver {
    
    var board: [[Int]] // for solved board
    
    init(board: [[Int]]) {
        self.board = board
    }
    
    private func checkRowColumn(row: Int, col: Int, number: Int) -> Bool {
        for i in 0..<9 {
            if board[row][i] == number || board[i][col] == number {
                return false
            }
        }
        return true
    }
    
    private func checkSmallBox(row: Int, col: Int, number: Int) -> Bool {
        let x = (row / 3) * 3
        let y = (col / 3) * 3
        
        for i in 0..<3 {
            for j in 0..<3 {
                if board[i + x][j + y] == number {
                    return false
                }
            }
        }
        return true
    }
    
    func solve() -> Bool {
        for row in 0..<9 {
            for col in 0..<9 {
                if board[row][col] == 0 {
                    for number in 1...9 {
                        if checkRowColumn(row: row, col: col, number: number)
                            && checkSmallBox(row: row, col: col, number: number) {
                            board[row][col] = number
                            if solve() {
                                return true
                            } else {
                                board[row][col] = 0
                            }
                        }
                    }
                    return false
                }
            }
        }
        return true
    }
    
    func toString(board: [[Int]]) -> String {
        var result = ""
        for i in 0..<9 {
            for j in 0..<9 {
                result += "\(board[i][j]) "
            }
            result += "\n"
        }
        return result
    }
    
    func getBoard() -> [[Int]] {
        return board
    }
    
    func setBoard(board: [[Int]]) {
        self.board = board
    }
}
