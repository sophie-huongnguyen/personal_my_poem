library(tidyr)
library(dplyr)

poem_list <- data.frame(poem_name = list.files("poems"))

poet_names <- lapply(poem_list$poem_name, function(each_poem){
  readLines(paste0("poems/", each_poem), encoding = "UTF-8")[3]
}) %>%
  unlist()

poem_src <- lapply(poem_list$poem_name, function(each_poem){
  readLines(paste0("poems/", each_poem), encoding = "UTF-8")[4]
}) %>%
  unlist()

poem_year <- lapply(poem_list$poem_name, function(each_poem){
  readLines(paste0("poems/", each_poem), encoding = "UTF-8")[5]
}) %>%
  unlist()

poem_list$poet <- poet_names
poem_list$collection <- poem_src
poem_list$year <- poem_year

write.csv(poem_list, "poem_list.csv", row.names = F)