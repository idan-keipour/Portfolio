import copy
import random
import time

# gets two cards and returns a list with the common symbols.
def cards_intersect(card1, card2):
    in_both = []
    for picture1 in card1:
        for picture2 in card2:
            if (picture1 == picture2):
                in_both.append(picture1)
    return in_both

# Checks if card is in deck and remove it
def remove_card(deck, card):
    for i in deck:
        if set(i)==set(card): #checks if the card is in the deck without importance to the symbols order
            deck.remove(i)
            return True
    print("Error! card is not in the deck!")
    return False

# Check if new card matches and add it to the deck
def add_card(deck, card):
    a= False
    for card1 in deck:
        if (len(card) == len(card1)):
            a= True  #only if the length of the new card matches the lengh of any card in the deck, a will be 'True'
    if a== False:
        print("Error! Card is of wrong length")
        return False
    for onecard in deck:  #checks for the new card if he has exacly 1 symbol matches.
        if (len(cards_intersect(onecard, card)) != 1):
                print("Error! number of matches for new card is not one ")
                return False
    deck.append(card)
    return True

# Check if a deck is valid
def is_valid(deck):
    for i in range(len(deck)):
        for j in range(i):  #checsk if there is more then 1 symbol matches between any of the cards in the deck
            if ((len(deck[i])) != (len(deck[j]))) or \
                    (len((cards_intersect(deck[i], deck[j]))) != 1): #cheks if there is card with different number of symbols
                return False
    return True

# Draw random cards from deck
def draw_random_cards(deck):
    drawn_cards = []
    a= random.randint(0,(len(deck)-1))
    b= random.randint(0,(len(deck)-1))
    while (a==b): #if the program random the same card- it will random a different card.
        b= random.randint(0,(len(deck)-1))
    drawn_cards.append(deck[a])
    drawn_cards.append(deck[b])
    return drawn_cards
# The programs prints which symbols appear in the deck and prints for each symbol how many times it appears.
def print_symbols_counts(deck):
    symbols = set(deck[0])
    for i in range(1,len(deck)):
        symbols = symbols.union(deck[i])
    symbols = list(symbols) #makes a list with the symbols. every symbol will apear just 1 time.
    for onesymbol in symbols:
        count = 0
        for i in range (len(deck)):
            for j in range (len(deck[i])): #cheks how many times every card appears.
                if (deck[i][j] == onesymbol):
                    count += 1
        print (onesymbol, count)

# Interactive function for playing the game
def play_dobble(deck):
    option = input("Select operation: (P)lay, (A)dd card, (R)emove card, or (C)ount\n") # Get option from user.
    if (option == "A"):   #If the user chose 'A', the program will get a card and try to add it to the deck.
        usercard = input().split(",")
        add_card(deck,usercard)
    elif (option == "R"): #If the user chose 'R', the program will get a card and try to remove it from the deck.
        usercard = input().split(",")
        remove_card(deck,usercard)
    elif (option == "C"): #If the user chose 'C', the program prints the amount of every card in the deck.
        print_symbols_counts(deck)
    elif (option == "P"):  #If the user chose 'P', the program will start the game.
        play_deck = copy.deepcopy(deck) #copy the deck so the changes durring the gamw won't affect it.
        wincount=0
        losscount=0
        wintime=0
        while (len(play_deck) >=2): #as long as there are more then 2 cards, the game is on.
            cards = draw_random_cards(play_deck)
            card1 = cards[0]
            card2 = cards[1]
            print("Identify joint symbol:")
            print(", ".join(card1))
            print(", ".join(card2))
            start = time.time()
            answer = input()
            finish = time.time()
            correct=cards_intersect(card1,card2)
            if (answer == correct[0]):
                print("Very nice! Found the correct card in" ,round(finish-start,2), "sec.")
                wincount+=1 #if the user chose the correct answer, it prints the time it took.
                wintime = wintime+(finish-start)
            else:
                print("Wrong!") #if the user chose the wrong answer, it prints "wrong!"
                losscount+=1
            remove_card(play_deck,card1)
            remove_card(play_deck,card2) #removes the cards we used in the game from the deck.
            #prints the statistics of the game
        if (wincount==0):
            print("Finished Game. Correct:", wincount, "Wrong:", losscount, "Average time: 0.0 sec.")
        else:
            print("Finished Game. Correct:", wincount, "Wrong:", losscount, "Average time:", round(wintime/wincount,2),"sec.")

