# Example of Unoptimised Script for Higher or Lower Card Game
# Author: Gareth Burns
# Date: 08/07/2023
# This is the Wrath.R script with the improvement of defining the using if else
# condition in place of ifesle function.
# See CodeOptimisation.qmd for details.

# User-defined Variables
# sims <- seq_len(1000)

# Create Deck of cards
deckValues <- rep(1:13, times = 4)

results <- lapply(sims, function(sim) {

  # Gameplay ----------------------------------------------------------------

  # An initial score of 1
  score <- 1L

  # Remove Card from Deck
  deck <- sample(deckValues, size = 52, replace = FALSE)

  outcome <- "Pending"

  while (outcome != "Lose") {
    # CODE EXPLANATION
    # Hand card: deck[1]
    # Drawn card: deck[2]
    logic <- if (deck[1] < 8) {
      ">"
    } else if (deck[1] > 8) {
      "<"
    } else if (deck[1] == 8) {
      sample(c(">", "<"), 1)
    }

    outcome <-
      if (isTRUE(do.call(
        logic, args = list(deck[2], deck[1])))) {
        "Win"
      } else {
        "Lose"
      }

    # Remove Card from Deck
    deck <- deck[-1]

    if (outcome == "Win") {
      score <- score + 1L
    }
  }

  # Append the result of current simulation
  return(score)

})

probability <- data.frame(score = seq_len(length(deckValues)),
                          NumberOfSims = NA_integer_)


# count <- aggregate(sim ~ score, data = results, length)

# probability$NumberOfSims <- count$sim[match(probability$score, count$score)]


