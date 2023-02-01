require 'pry'

class TicTacToe

    WIN_COMBINATIONS = [
        [0,1,2], #top row
        [3,4,5], #middle row
        [6,7,8], #bottom row
        [0,3,6], #left column
        [1,4,7], #middle column
        [2,5,8], #right column
        [0,4,8], #left to right diagonal
        [2,4,6] #right to left diagonal
    ]

    def initialize()
        @board = [" "," "," "," "," "," "," "," "," "]
    end

    def display_board
        first_row = " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        second_row = " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        third_row = " #{@board[6]} | #{@board[7]} | #{@board[8]} "
        line_break = "-----------"

        p first_row
        p line_break
        p second_row
        p line_break
        p third_row
    end

    def input_to_index number
        number.to_i - 1
    end

    def move index, token = "X"
        @board[index] = token
    end

    def position_taken? index
        @board[index] != " "
    end

    def valid_move? index
        index >= 0 && index <= 8 && !position_taken?(index)
    end

    def turn_count
        @board.count { |position| position != " " }
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Please enter a number 1-9"
        user_input = gets.strip
        index = input_to_index(user_input)
        if valid_move?(index)
            move(index, current_player)
            display_board
        else
            turn
        end
    end

    def won?

        #iterate over win combinations
        WIN_COMBINATIONS.detect do |combo|
            #for combo indices, is it all X's or O's
            if @board[combo[0]] == @board[combo[1]] && 
                @board[combo[1]] == @board[combo[2]] &&
                position_taken?(combo[0])
                return combo
            end
        end
    end

    def full?
        @board.all? do |index|
            index != " "
        end
    end

    def draw?
        full? && !won?
    end

    def over?
        won? || draw?
    end

    def winner
        won? ? @board[won?[0]] : nil
    end

    def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end

end