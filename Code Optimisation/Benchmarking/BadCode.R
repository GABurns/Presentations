# Example of Unoptimised Script for Higher or Lower Card Game
# Author: Gareth Burns
# Date: 31/07/2023
# This code is an example of script that was put together as a first draft
# to carry out out the Higher or Lower card game app for the purposes of
# evaluating the probability of a given score for social media purposes.
# Objective: You have been handed this script and asked to optimise the time
# it takes to run. You can use any packages, functions but must be run within R.
# The code must produce an output that contains an R object that contains score
# and the number of simulations that obtained the score.

# User-defined Variables
# sims <- seq_len(10000)

for (i in sims) {
  # Create Deck of cards
  suit <- rep(c("spade", "club", "heart", "diamond"), each = 13)
  color <- rep(c("black", "red"), each = 26)
  label <- rep(c(2:10, "Jack", "Queen", "King", "Ace"), times = 4)
  value <- rep(1:13, times = 4)
  deck <-
    data.frame(suit, color, label, value, stringsAsFactors = FALSE)


  # Gameplay ----------------------------------------------------------------

  # An initial score of 1
  score <- 1L

  handCardIndex <-
    sample(seq(nrow(deck)), size = 1, replace = FALSE)
  handCard <- deck[handCardIndex, ]

  # Remove Card from Deck
  deck <- deck[-handCardIndex, ]

  outcome <- "Pending"

  while (outcome != "Lose") {
    logic <- if (handCard$value < 8) {
      ">"
    } else if (handCard$value > 8) {
      "<"
    } else if (handCard$value == 8) {
      sample(c(">", "<"), 1)
    }

    # Draw a card
    drawnCardIndex <-
      sample(seq(nrow(deck)), size = 1, replace = FALSE)
    drawnCard <- deck[drawnCardIndex, ]

    # Remove Card from Deck
    deck <- deck[-drawnCardIndex, ]

    outcome <-
      ifelse(isTRUE(do.call(
        logic, args = list(drawnCard$value, handCard$value)
      )), "Win", "Lose")

    if (outcome == "Win") {
      score <- score + 1L
      handCard <- drawnCard
    }
  }

  ifelse(file.exists("results.csv"),
         {
           results <- read.csv("results.csv", colClasses = c("integer", "integer"))

         },
         {
           # ifelse to account for special case of first simulations
           results <- data.frame(sim = integer(0L),
                                 score = integer(0L))
         })

  # Append the result of current simulation
  results[i,] <- c(i, score)

  # Output ------------------------------------------------------------------
  write.csv(results, "results.csv", row.names = FALSE)

}

#
results <- read.csv("results.csv", colClasses = c("integer", "integer"))

# probability <- data.frame(score = seq_len(nrow(deck)),
#                           NumberOfSims = NA_integer_)
#
#
# count <- aggregate(sim ~ score, data = results, length)
#
# probability$NumberOfSims <- count$score[match(probability$score, count$outcome)]


