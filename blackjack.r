# Define a function to calculate the value of a hand
hand_value <- function(hand) {
  total <- sum(ifelse(hand == "A", 11, ifelse(hand %in% c("K", "Q", "J"), 10, as.numeric(hand))))
  aces <- sum(hand == "A")
  while(total > 21 & aces > 0) {
    total <- total - 10
    aces <- aces - 1
  }
  return(total)
}

# Define a function to display the cards in a hand
display_hand <- function(hand) {
  cat(paste(hand, collapse=" "))
  cat(" (", hand_value(hand), ")\n")
}

# Set up the game
deck <- rep(c("A", 2:10, "J", "Q", "K"), 4)
shuffle <- sample(length(deck))
deck <- deck[shuffle]
player_hand <- deck[1:2]
dealer_hand <- deck[3:4]

# Play the game
while(hand_value(player_hand) <= 21) {
  cat("Your hand: ")
  display_hand(player_hand)
  
  if(hand_value(player_hand) == 21) {
    cat("Blackjack! You win.\n")
    break
  }
  
  action <- readline(prompt="Do you want to hit (h) or stand (s)? ")
  if(action == "h") {
    player_hand <- c(player_hand, deck[length(player_hand) + 3])
  } else {
    break
  }
}

if(hand_value(player_hand) > 21) {
  cat("Bust. You lose.\n")
} else {
  cat("\nDealer's hand: ")
  display_hand(dealer_hand)
  
  while(hand_value(dealer_hand) < 17) {
    dealer_hand <- c(dealer_hand, deck[length(dealer_hand) + 3])
    cat("Dealer hits.\n")
  }
  
  if(hand_value(dealer_hand) > 21) {
    cat("Dealer busts. You win!\n")
  } else if(hand_value(player_hand) > hand_value(dealer_hand)) {
    cat("You win!\n")
  } else if(hand_value(player_hand) < hand_value(dealer_hand)) {
    cat("You lose.\n")
  } else {
    cat("Push.\n")
  }
}
