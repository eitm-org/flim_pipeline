library(here)
library(tidyverse)
library(readxl)
library(plater)
library(janitor)

here::i_am("FLIM_Analysis_Newdata.Rmd")



source(here("R", "functions.R"))

############################
# download DRC data from dropbox
############################
db_dest <- here("data", "dropbox")
dropbox_downloader("https://www.dropbox.com/scl/fo/l1ccs9j283ztkarf5mdbu/AH7U_kik_o6f80hoqlISTqU?rlkey=2leaw3nfs75twbcjgbqd1ci53&st=d7jzdaf4&dl=1", db_dest)



############################
# import  data
############################
#list all files you copied over from dropbox
all_paths <- list.files(file.path(db_dest, "unzipped"), recursive = TRUE, full.names = TRUE)
all_paths
target_path <- "/Users/scoban/Documents/GitHub/flim_pipeline/data/dropbox/unzipped/SimFCS_FLIM-pipeline-test_v2.xlsx"
matching_path <- all_paths[grep(target_path, all_paths, fixed = TRUE)]

matching_path
df <- matching_path %>%
  map(read_data) %>%
  bind_rows()


all_paths



library(dplyr)
library(knitr)

avg_df <- df %>% group_by(sample_id) %>% mutate(meanG = mean(g), mean_f_b = mean(f_b))  %>% ungroup()


saveRDS(df, file = here("data", paste0("data_cleaning_output1", ".RDS")))
saveRDS(avg_df, file = here("data", paste0("data_cleaning_output_avg1", ".RDS")))

