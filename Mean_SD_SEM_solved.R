
###### Mean_SD_SEM Plot using tidyr/dplyr ######

# I wanted to post this for 2 reasons

## 1) The first time I attempted this practice problem after TJ gave it to our class, I utterly failed, 
## so I wanted to take another swing at it

## 2) This method does not rely on knowing the exact dimensions of a complex matrix (ie more than 2 dimensions)
## There is nothing wrong with the matrix method, but I have found recently that using lists and dplyr's nest() and unnest() functions
## are extremely powerful and can allow you to organize vast amounts of data that are of different dimensions and/or types

# NOTE: If you download this, I encourage you to check out the PRACTICE ZONE at the bottom. I've placed a single function on each line. This is more "interactive" and
# was basically how I step by step built my function until it was complete. Selectively comment out functions or change arguments
# and see how the data object you build responds

library(tidyverse)

m = 100     #mean
sd = 25     #standard deviation
n = c(2:50) #sample sizes
r = 75      #replications

l = list()                                               #Create and empty list to store values in

for(i in c(n)) {
  l[[i-1]] <- 
    replicate(r, rnorm(i, m, sd)) %>%                    #Immediately, I want to generate the 75 values of my sample size.
    as.data.frame() %>%                                  #Convert from list to data.frame
    mutate(sample_size = i) %>%                          #Create a column for sample size
    pivot_longer(cols = -sample_size,                    #Pivot the table to be longer for each column except sample size
                 names_to = "iteration", 
                 names_prefix = "V",                     #This line removes the "V" that's placed in column names
                 values_to = "values") %>% 
    group_by(iteration, sample_size) %>%                 #Group by iteration since we are summarizing from this long data.frame. Need to group_by sample_size too even thought there should only be one sample_size at a time in the loop. Why is this? Delete sample_size and replace it in the interactive to see
    summarise(av = mean(values), sd = sd(values)) %>%    #Summarize mean and sd first
    mutate(sem = sd/sqrt(sample_size)) %>%               #Then mutate (not summarize) to generate an sem score by using the sd and sample_size row-wise
    ungroup() %>% group_by(sample_size) %>%              #Ungroup to ungroup by iteration, then regroup by sample_size for the nesting
    nest() %>%                                           #Nest that long data.frame object into a single row of a "super" data.frame
    ungroup()                                            #Ungroup before we save into the list to have a completely ungrouped list object. This will be useful in the next step
}

l %>% cbind() %>% as.data.frame() %>%                    #Kind of counterintuitively, you need to cbind instead of rbind. But check out the output by doing l %>% cbind() %>% as.data.frame() down below, and you'll see what your output is
  unnest(cols = c(.)) %>% unnest(cols = c(data)) %>%     #Unnest two times. Yes, two times. Look below to see what each unnest() call does to the object
  select(-iteration) %>%                                 
  pivot_longer(cols = -sample_size,                      
               names_to = "parameter", 
               values_to = "value") %>% 
  ggplot(aes(sample_size, value, color = parameter))+
  geom_point(alpha = 0.2)+
  theme_classic()+
  xlab("Sample Size") + ylab("Estimated Value")+
  ggtitle("Estimation of Mean and Standard Deviation improves with sample size more 
slowly than Standard Error of the Mean")


################################################################################################

## PRACTICE ZONE

#Each function is placed on its own line to make it easy to comment out a line and see the output.

## Note: when you are uncommenting lines, be sure that you don't accidentally leave an unwanted pipe (%>%)! 

#for(i in c(2:5)) {
#  replicate(75, rnorm(i, m, sd)) %>% 
#    as.data.frame() %>% 
#    mutate(sample_size = i) %>% 
#    pivot_longer(cols = -sample_size, names_to = "iteration", names_prefix = "V", values_to = "values") %>% 
#    group_by(iteration, sample_size) %>% 
#    summarise(av = mean(values), sd = sd(values)) %>% 
#    mutate(sem = sd/sqrt(sample_size)) %>% 
#    ungroup() %>% 
#    group_by(sample_size) %>% 
#    nest() %>% 
#    ungroup() %>% 
#    print()
#}

#for(i in c(2:5)) {
#  l[[i-1]] <- replicate(75, rnorm(i, m, sd)) %>% 
#    as.data.frame() %>%                                                                                     
#    mutate(sample_size = i) %>% 
#    pivot_longer(cols = -sample_size, names_to = "iteration", names_prefix = "V", values_to = "values") %>% 
#    group_by(iteration, sample_size) %>% 
#    summarise(av = mean(values), sd = sd(values)) %>% 
#    mutate(sem = sd/sqrt(sample_size)) %>% 
#    ungroup() %>% 
#    group_by(sample_size) %>% 
#    nest() %>% 
#    ungroup() 
#}

#l %>% 
#  cbind() %>% 
#  as.data.frame() %>% 
#  unnest(cols = c(.)) %>% 
#  unnest(cols = c(data)) %>% 
#  select(-iteration) %>% 
#  pivot_longer(cols = -sample_size, names_to = "parameter", values_to = "value") %>% 
#  ggplot(aes(sample_size, value, color = parameter))+
#   geom_point(alpha = 0.2)+
#   theme_classic()+
#   xlab("Sample Size") + ylab("Estimated Value")+
#   ggtitle("Estimation of Mean and Standard Deviation improves with sample size more 
# slowly than Standard Error of the Mean")
