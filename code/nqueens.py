import argparse
import numpy as np


class NQueenPuzzle:
    def __init__(self, size):
        self.size = size
        self.number_of_solutions = 0


def print_board(nqueens, positions):
    for row in range(nqueens.size):
        for column in range(nqueens.size):
            if positions[row] == column:
                print("Q ", end="")
            else:
                print(". ", end="")
        print("")
    print("")


def not_under_attack(positions, occupied_rows, column):
    for i in range(occupied_rows):
        if (
            positions[i] == column
            or positions[i] - i == column - occupied_rows
            or positions[i] + i == column + occupied_rows
        ):
            return False
    return True


def place_queen(nqueens, positions, target_row):
    if target_row == nqueens.size:
        print_board(nqueens, positions)
        nqueens.number_of_solutions += 1
    else:
        for column in range(nqueens.size):
            if not_under_attack(positions, target_row, column):
                positions[target_row] = column
                place_queen(nqueens, positions, target_row + 1)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--size", help="Size of problem", type=int, default=8)
    parser.add_argument(
        "--repeats", help="Number of repeat runs", type=int, required=False, default=1
    )
    args = parser.parse_args()

    nqueens = NQueenPuzzle(args.size)
    positions = [-1] * nqueens.size
    for i in range(args.repeats):
        positions = [-1] * nqueens.size
        nqueens.number_of_solutions = 0
        place_queen(nqueens, positions, 0)
        print("Found", nqueens.number_of_solutions, "solutions")


if __name__ == "__main__":
    main()
