program main
    implicit none
    integer, allocatable :: positions(:)
    integer :: cmdl_cnt, problem_size, repeats, i
    character(len=10) :: buffer

    type :: nqueen_puzzle
        integer :: size
        integer :: number_of_solutions
    end type nqueen_puzzle


    type(nqueen_puzzle) :: nqueens

    cmdl_cnt = int(command_argument_count())

    if(cmdl_cnt == 0) then
        problem_size = 8
        repeats = 1
    else if(cmdl_cnt == 1) then
        call get_command_argument(1, buffer)
        read(buffer, *) problem_size 
        repeats = 1
    else 
        call get_command_argument(1, buffer)
        read(buffer, *) problem_size 
        call get_command_argument(2, buffer)
        read(buffer, *) repeats 
    end if

    nqueens%size = problem_size
    allocate(positions(nqueens%size))
    do i = 1, repeats
        positions = 0
        nqueens%number_of_solutions = 0
        call place_queen(nqueens, positions, 1)
        print *, "Found ", nqueens%number_of_solutions, " solutions"
    end do
    deallocate(positions)

    contains

    subroutine print_board(nqueens, positions)
        type(nqueen_puzzle), intent(in) :: nqueens
        integer, intent(in) :: positions(:)
        integer :: row, column

        do row = 1, nqueens%size
            do column = 1, nqueens%size
                if (positions(row) == column) then
                    write(*, '(A)', advance='no') "Q "
                else
                    write(*, '(A)', advance='no') ". "
                end if
            end do
            print *, ""
        end do
        print *, ""
    end subroutine print_board

    logical function not_under_attack(positions, occupied_rows, column)
        integer, intent(in) :: positions(:)
        integer, intent(in) :: occupied_rows, column
        integer :: i

        not_under_attack = .true.
        do i = 1, occupied_rows - 1
            if (positions(i) == column .or. positions(i) - i == column - occupied_rows .or. positions(i) + i == column + occupied_rows) then
                not_under_attack = .false.
                return
            end if
        end do
    end function not_under_attack

    recursive subroutine place_queen(nqueens, positions, target_row)
        type(nqueen_puzzle), intent(inout) :: nqueens
        integer, intent(inout) :: positions(:)
        integer, intent(in) :: target_row
        integer :: column

        if (target_row > nqueens%size) then
            call print_board(nqueens, positions)
            nqueens%number_of_solutions = nqueens%number_of_solutions + 1
        else
            do column = 1, nqueens%size
                if (not_under_attack(positions, target_row, column)) then
                    positions(target_row) = column
                    call place_queen(nqueens, positions, target_row + 1)
                end if
            end do
        end if
    end subroutine place_queen

end program main