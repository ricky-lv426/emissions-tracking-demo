// The n queens puzzle.
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int size;
    int number_of_solutions;
} nqueen_puzzle;

void show_board(nqueen_puzzle nqueens, int *positions);
bool check_place(int *positions, int occupied_rows, int column);
void place_queen(nqueen_puzzle *nqueens, int *positions, int target_row);

int main(int argc, char **argv) {

    int problem_size;
    int repeats;

    if(argc == 1){
        problem_size = 8;
        repeats = 1;
    } else if(argc == 2 ){
        problem_size = atoi(argv[1]);
        repeats = 1;
    } else {
        problem_size = atoi(argv[1]);
        repeats = atoi(argv[2]);
    }

    nqueen_puzzle nqueens;
    nqueens.size = problem_size;
    
    int *positions = (int *)malloc(nqueens.size * sizeof(int));
    for (int i = 0; i < repeats; i++) {
        for (int i = 0; i < nqueens.size; i++) {
            positions[i] = 0;
        }
        nqueens.number_of_solutions = 0;
        place_queen(&nqueens, positions, 1);
        // printf("Found %d solutions\n", nqueens.number_of_solutions);
    }
    free(positions);
    return 0;
}

void print_board(nqueen_puzzle nqueens, int *positions) {
    for (int row = 1; row <= nqueens.size; row++) {
        for (int column = 1; column <= nqueens.size; column++) {
            if (positions[row - 1] == column) {
                printf("Q ");
            } else {
                printf(". ");
            }
        }
        printf("\n");
    }
    printf("\n");
}

bool not_under_attack(int *positions, int occupied_rows, int column) {
    for (int i = 1; i < occupied_rows; i++) {
        if (positions[i - 1] == column || 
            positions[i - 1] - i == column - occupied_rows || 
            positions[i - 1] + i == column + occupied_rows) {
            return false;
        }
    }
    return true;
}

void place_queen(nqueen_puzzle *nqueens, int *positions, int target_row) {
    if (target_row > nqueens->size) {
        // print_board(*nqueens, positions);
        nqueens->number_of_solutions++;
    } else {
        for (int column = 1; column <= nqueens->size; column++) {
            if (not_under_attack(positions, target_row, column)) {
                positions[target_row - 1] = column;
                place_queen(nqueens, positions, target_row + 1);
            }
        }
    }
}