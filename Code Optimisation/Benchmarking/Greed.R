# Example of Unoptimised Script for Higher or Lower Card Game
# Author: Gareth Burns
# Date: 08/07/2023
# This is the Gluttony.R script with the improvement of defining the creating the
# deck outside the for loop and as a numeric vector instead of data.frame
# See CodeOptimisation.qmd for details.

# User-defined Variables
# sims <- seq_len(1000)

results <- data.frame(sim = numeric(length(sims)),
                      score = numeric(length(sims)))

# Create Deck of cards
deckValues <- rep(1:13, times = 4)

for (i in sims) {
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
      ifelse(isTRUE(do.call(
        logic, args = list(deck[2], deck[1])
      )), "Win", "Lose")


    # Remove Card from Deck
    deck <- deck[-1]

    if (outcome == "Win") {
      score <- score + 1L
    }
  }

  # Append the result of current simulation
  results[i,] <- c(i, score)
}


# probability <- data.frame(score = seq_len(length(deckValues)),
#                           NumberOfSims = NA_integer_)
#
#
# count <- aggregate(sim ~ score, data = results, length)
#
# probability$NumberOfSims <- count$sim[match(probability$score, count$score)]


