# Implement sudoku solving
import random
import copy
# from sudoku_helper import sudoku_action


# 1. Check if board is complete
def sudoku_iscomplete(board):
    for line in board: #pass on all of the lines in the board
        if (0 in line): #if 0 is one of the elements in the line the sudoku is not complete (and so' returns False)
            return False
    return True #if not even one of the nnumbers in the board is 0, the board is complete

# 2. Return the 3*3 square covering x,y
def sudoku_square3x3(board, x, y):
    x = (x // 3) * 3 #checks in which line the square of the coordinate starts.
    y = (y // 3) * 3 #checks in which colom the square of the coordinate starts.
    square = [[], [], []] #build a new list with 3 parts, one for each line in the square
    for i in range(3):
        for j in range(3): #pass on the 9 elements in the square and add it to the new list
            square[i].append(board[x + i][y + j])
    return square #returns a "list of lists" which every part of the list is one line in the square

# 3. Get available options of a position
def sudoku_options(board, x, y, diag=False):
    options = {1, 2, 3, 4, 5, 6, 7, 8, 9} #all the possible options to have in a single sudoku inlay
    memory = board[x][y] # to remember what number we have in the inlay before we "called" the function
    # we don't want the number we have in the position affect the options it can contain so wee reset it to 0
    board[x][y] = 0
    for i in range(9): # pass on all of the numbers in the line of the square we want to check.
        if board[x][i] in options: # removes all the numbers in the line from the possible numbers of the square we're chacking
            options.remove(board[x][i])
    for j in range(9): # pass on all of the numbers in the colum of the square we want to check.
        if board[j][y] in options:
            options.remove(board[j][y]) # removes all the numbers in the column from the possible numbers of the square we're chacking
    sqr = sudoku_square3x3(board, x, y) #to get the square of the place we're chacking
    for line in sqr:
        for n in range(len(line)): # pass on all of the numbers in the square of the place  we want to check.
            if line[n] in options:
                options.remove(line[n])# removes all the numbers in the column from the possible numbers of the place we're chacking
    board[x][y] = memory #returns the number was in the inlay to himself
    return options #returns all of the options possible to a single place in the sudoku table

# 4. find all positions which have one option to fill
def find_all_unique(board):
    uni = [] #make a new list so we can add to it the results we get
    for i in range(9):
        for j in range(9): #pass on all of the board
            if board[i][j] == 0: #if on of the inlay is not full we will chack what options it can contain
                option = list(sudoku_options(board,i,j))
                if (len(option) == 1): #if there is just 1 option possible we will add it to the list
                    a= i,j,option[0]
                    uni.append(a)
    # in the end, we'll have a list with the cordinates and value for all of the placed which have only 1 possibles to fill
    return uni

# 5. Find squares with no option to fill
def find_all_conflicts(board):
    mistakes = [] #makes a new list so we can add the result to it
    for i in range(9):
        for j in range(9): #pass on all of the board
            option = list(sudoku_options(board, i, j)) #checks the options to have in the square
            if (len(option) == 0): #if there is not even 1 option it means we have a mistake in this square
                a= i,j
                mistakes.append(a) #add the cordinate of the mistake to the list
    return mistakes #returns all the cordinates of mistakes we have in the board

# 6. Add square:
def add_square(board, i, j, val):
    options= sudoku_options(board,i,j) #cheks the option to have in a given sudoku square
    if val in options: #if the value is a correct answer it will add it to the board
        board[i][j] = val
        return True
    print("Error! Value in conflict with current board") #if the value is not a correct answer it will print a suitable message
    return False

# function helps to know if a full board is correct or not
def is_fixed(board):
    for i in range(9):
        for j in range(9):  #pass on all of the board
            if len(sudoku_options(board,i,j)) != 1: #if there is a mistake in the board it will return False
                return False
    return True #if the board is correct, the function returns True

# 7. Iteratively fill the board with unique options
def fill_board(board):
    while ((len(find_all_unique(board)))>0): #the loop is running as long as there are more numbers to fill on the board
        for i in range(9):
            for j in range(9): #pass on all of the board and checks the options in the inlay.
                options = list(sudoku_options(board, i, j))
                if len(options) == 1:
                    board[i][j] = options[0] #if there is only 1 option, it will add it to the square.
                elif len(options) == 0: #if there is not even 1 option it means we have a mistake so it prints a suitable message
                    print("Error! current sudoku leads to inconsistencies. Must delete values")
                    return False
    if sudoku_iscomplete(board) and is_fixed(board): #in the end, if the board is complete and the sulotion is good
        print("Success! sudoku solved") # it prints a success message
        return True
    elif sudoku_iscomplete(board) == False: #if the board is not completed it prints a message that the board is not perfectly full
        print("Sudoku partially solved")
        return True
    elif is_fixed(board) == False: #if the sudoku is full but with a mistake, it prints to delete values
        print("Error! current sudoku leads to inconsistencies. Must delete values")
        return False
