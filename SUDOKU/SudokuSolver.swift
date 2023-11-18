import Foundation

class SudokuSolver {
    var board: [[Int]]

    init(board: [[Int]]) {
        self.board = board
    }

    private func isValid(_ row: Int, _ col: Int, _ num: Int) -> Bool {
        // Check if the number is not in the current row and column
        for i in 0..<9 {
            if board[row][i] == num || board[i][col] == num {
                return false
            }
        }

        // Check if the number is not in the current 3x3 box
        let boxStartRow = row - row % 3
        let boxStartCol = col - col % 3
        for i in 0..<3 {
            for j in 0..<3 {
                if board[boxStartRow + i][boxStartCol + j] == num {
                    return false
                }
            }
        }

        return true
    }

    private func findEmptyLocation() -> (row: Int, col: Int)? {
        for i in 0..<9 {
            for j in 0..<9 {
                if board[i][j] == 0 {
                    return (i, j)
                }
            }
        }
        return nil
    }

    func solve() -> Bool {
        guard let emptyLocation = findEmptyLocation() else {
            // No empty location, puzzle is solved
            return true
        }

        let row = emptyLocation.row
        let col = emptyLocation.col

        for num in 1...9 {
            if isValid(row, col, num) {
                board[row][col] = num

                if solve() {
                    return true
                }

                // If placing the number at (row, col) doesn't lead to a solution, backtrack
                board[row][col] = 0
            }
        }

        // No valid number found, need to backtrack
        return false
    }

    func getBoard() -> [[Int]] {
        return board
    }
}



