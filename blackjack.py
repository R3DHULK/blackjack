import tkinter as tk
import random

# Constants
CARD_VALUES = {
    'Ace': 11,
    'Two': 2,
    'Three': 3,
    'Four': 4,
    'Five': 5,
    'Six': 6,
    'Seven': 7,
    'Eight': 8,
    'Nine': 9,
    'Ten': 10,
    'Jack': 10,
    'Queen': 10,
    'King': 10
}
DEALER_LIMIT = 17

# Initialize the deck
deck = list(CARD_VALUES.keys()) * 4

# Initialize the GUI
root = tk.Tk()
root.title('Blackjack Game')

# Create the frames
player_frame = tk.Frame(root)
dealer_frame = tk.Frame(root)
button_frame = tk.Frame(root)

# Create the labels
player_label = tk.Label(player_frame, text='Player')
dealer_label = tk.Label(dealer_frame, text='Dealer')

# Create the card labels
player_card_labels = []
dealer_card_labels = []

for i in range(5):
    player_card_labels.append(tk.Label(player_frame))
    dealer_card_labels.append(tk.Label(dealer_frame))

# Create the buttons
hit_button = tk.Button(button_frame, text='Hit')
stand_button = tk.Button(button_frame, text='Stand')

# Pack the widgets
player_label.pack(side=tk.TOP, pady=5)
dealer_label.pack(side=tk.TOP, pady=5)

for label in player_card_labels:
    label.pack(side=tk.LEFT, padx=5)

for label in dealer_card_labels:
    label.pack(side=tk.LEFT, padx=5)

hit_button.pack(side=tk.LEFT, padx=5, pady=10)
stand_button.pack(side=tk.LEFT, padx=5, pady=10)

player_frame.pack(side=tk.TOP, pady=10)
dealer_frame.pack(side=tk.TOP, pady=10)
button_frame.pack(side=tk.TOP, pady=10)

# Initialize the game variables
player_cards = []
dealer_cards = []
player_total = 0
dealer_total = 0

# Functions


def shuffle_deck():
    global deck
    deck = list(CARD_VALUES.keys()) * 4
    random.shuffle(deck)


def deal_cards():
    global player_cards, dealer_cards, player_total, dealer_total
    player_cards = [deck.pop(), deck.pop()]
    dealer_cards = [deck.pop(), deck.pop()]
    player_total = get_card_total(player_cards)
    dealer_total = get_card_total(dealer_cards)
    show_cards()


def show_cards():
    # Show player's cards
    for i, card in enumerate(player_cards):
        player_card_labels[i].config(text=card)
    for i in range(len(player_cards), 5):
        player_card_labels[i].config(text='')

    # Show dealer's cards
    dealer_card_labels[0].config(text=dealer_cards[0])
    dealer_card_labels[1].config(text='?')
    for i in range(2, len(dealer_cards)):
        dealer_card_labels[i].config(text=dealer_cards[i])
    for i in range(len(dealer_cards), 5):
        dealer_card_labels[i].config(text='')


def get_card_total(cards):
    total = 0
    num_aces = 0
    for card in cards:
        if card == 'Ace':
            num_aces += 1
        total += CARD_VALUES[card]
    while num_aces > 0 and total > 21:
        total -= 10
        num_aces -= 1
    return total


def dealer():
    global dealer_total
    show_cards()
    while dealer_total < DEALER_LIMIT:
        dealer_cards.append(deck.pop())
        dealer_total = get_card_total(dealer_cards)
        show_cards()
    end_game()


def hit():
    global player_cards, player_total
    player_cards.append(deck.pop())
    player_total = get_card_total(player_cards)
    show_cards()
    if player_total > 21:
        end_game()


def stand():
    dealer()


def end_game():
    global player_total, dealer_total
    # Show dealer's cards
    for i, card in enumerate(dealer_cards):
        dealer_card_labels[i].config(text=card)
    dealer_card_labels[1].config(text='')
    # Determine the winner
    if player_total > 21:
        tk.messagebox.showinfo('Game Over', 'You busted! Dealer wins!')
    elif dealer_total > 21:
        tk.messagebox.showinfo('Game Over', 'Dealer busted! You win!')
    elif dealer_total >= player_total:
        tk.messagebox.showinfo('Game Over', 'Dealer wins!')
    else:
        tk.messagebox.showinfo('Game Over', 'You win!')
    # Prompt the player to play again
    if tk.messagebox.askyesno('Play Again', 'Do you want to play again?'):
        shuffle_deck()
        deal_cards()
    else:
        root.destroy()


# Shuffle the deck and deal the cards
shuffle_deck()
deal_cards()

# Bind the buttons
hit_button.config(command=hit)
stand_button.config(command=stand)

root.mainloop()
