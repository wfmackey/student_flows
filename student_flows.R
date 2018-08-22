
project <- "student_flows"

setwd(paste0("~/Documents/git/", project))


## This section is a modified version of Emil Hvitfeldt's recreation of TheUpshot's "Extensive data shows punishing reach of racism for black boys"
    # https://www.nytimes.com/interactive/2018/03/19/upshot/race-class-white-and-black-men.html
    # https://www.hvitfeldt.me/2018/03/recreate-sankey-flow-chart/




library(devtools)
install_github("dgrtwo/gganimate", force = TRUE)

library(dplyr)
library(ggplot2)
library(broom)
library(gganimate)
library(tidyr)



library(ggplot2)
library(gganimate)

ggplot(mtcars, aes(factor(cyl), mpg)) + 
  geom_boxplot() + 
  # Here comes the gganimate code
  transition_states(
    gear,
    transition_length = 2,
    state_length = 1
  ) +
  enter_fade() + 
  exit_shrink() +
  ease_aes('sine-in-out')


# usedata <- lfs.2534.uniform %>% filter(gender == "f.haschild") %>% filter(grepl("B.", qualfield))
usedata <- lfs.2534.uniform %>% filter(grepl("B.", qualfield)) %>% filter(gender != "f")
typename <- "lfs"

#Settings
lfs.labels = c( "Employed FT", 
                "Employed PT",
                "Employed AWAY",
                "NILF",
                "Unemployed")
lfs.colors = c( gyellow,
                gorange,
                gdark,
                ggrey,
                gred)

usedata %>%
  ggplot() + 
  geom_bar(aes(y = pc, x = year, fill = lfs), stat="identity") +
  facet_grid(. ~ qualfield) +
  theme_minimal() +
  labs(title = "Labour-force status",
       x = "",
       y = ""
  ) +
  theme(plot.title    = element_text(size = 12, hjust = 0.5),
        plot.subtitle = element_text(size = 10, hjust = 0.5, face = "italic"),
        legend.position="bottom",
        legend.title = element_blank(),
        legend.text = element_text(size=8),
        strip.text.x = element_text(size = 10, colour = "black", angle = 90, hjust = 1, vjust = 1),
        axis.text.x=element_text(size=8, angle = 90),
        panel.grid.major.x=element_blank()
  ) +
  scale_fill_manual(labels = get(paste0(typename,".labels")),
                     values =  get(paste0(typename,".colors"))) +
  # ## gganimate
  transition_states(
    year,
    transition_length = 5,
    state_length = 2
  ) +
  transition_states(
    gender,
    transition_length = 5,
    state_length = 2
  ) +
  enter_fade() +
  exit_shrink() +
  ease_aes('sine-in-out') +
  NULL


anim_save("lfs_transition.gif")
  

