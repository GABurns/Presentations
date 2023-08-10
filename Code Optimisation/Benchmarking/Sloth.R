# Example of Unoptimised Script for Higher or Lower Card Game
# Author: Gareth Burns
# Date: 08/07/2023
# This is the BadCode.R script with the improvement of defining the colClasses
# arguement in the read.csv function
# See CodeOptimisation.qmd for details.

# User-defined Variables
# sims <- seq_len(1000)

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
results <- read.csv("results.csv", colClasses =  c("integer", "integer"))

# probability <- data.frame(score = seq_len(nrow(deck)),
#                           NumberOfSims = NA_integer_)
#
#
# count <- aggregate(sim ~ score, data = results, length)

probability$NumberOfSims <- count$score[match(probability$score, count$outcome)]


