# Author: Gareth Burns
# Date: 09/08/2023
# Description: 7 Simulation Sins Rainfall Plot for social media
# Dependencies: results are generated from Benchmark.R


# Load Libraries ----------------------------------------------------------
library(ggplot2)
library(showtext)
library(ggdist)
library(stringr)


# User-defined variables
primaryColour <- "red"
secondaryColour <- "darkred"
textColour <- "white"

# Plot Code ---------------------------------------------------------------

font_add_google("Creepster", family = "Creepster")

plot <-
  ggplot(results, aes(y = reorder(expr, desc(expr)), x = log10(time))) +
  ggdist::stat_dots(side = "bottomleft",
                    fill = secondaryColour,
                    col = primaryColour) +
  stat_slab(side = "topright",
            col = primaryColour,
            fill = secondaryColour) +
  labs(
    x = "Duration",
    y = NULL,
    title = str_wrap("7 SIMULATION SINS", width = 30),
    subtitle = str_wrap("Effect on script run-time by Absolution of each sin", width = 75),
    caption = str_wrap(
      "1,000 simulations run 50 times.| Pride is the final sin... | Committed by: Gareth Burns",
      width = 95
    )
  )   +
  theme(
    axis.ticks.y = element_blank(),
    axis.text = element_text(colour = primaryColour),
    axis.text.x = element_blank(),
    panel.grid = element_blank(),
    strip.background = element_blank(),
    strip.text = element_text(color = textColour, size = 15),
    panel.background = element_blank(),
    text = element_text(color = primaryColour, family = "Creepster"),
    plot.background = element_rect(fill = "black", color = "black"),
    plot.title = element_text(size = 40),
    plot.subtitle = element_text(size = 12),
    plot.caption = element_text(
      size = 10,
      hjust = 0,
      color = "white",
      family = "mono",
      vjust = -5
    ),
    plot.margin = unit(c(1.25, 1, 1, 1), "cm"),
  )
