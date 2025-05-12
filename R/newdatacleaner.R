library(here)
library(tidyverse)
library(readxl)
library(plater)
library(janitor)

here::i_am("FLIM_Template_Demo.Rmd")
source(here("R", "functions.R"))
db_dest <- here("data", "dropbox")


# Put the link to the dropbox folder here:
dropbox_link <- "https://www.dropbox.com/scl/fo/l1ccs9j283ztkarf5mdbu/AH7U_kik_o6f80hoqlISTqU?rlkey=2leaw3nfs75twbcjgbqd1ci53&st=jiqw3gtu&dl=1"
dropbox_downloader(dropbox_link, db_dest)


#list all files you copied over from dropbox
all_paths <- list.files(file.path(db_dest, "unzipped"), recursive = TRUE, full.names = TRUE)
all_paths
target_filename <- "Ken-MATLAB_FLIM-pipeline-test_v2.xlsx" 
matching_path <- all_paths[grep(target_filename, all_paths, fixed = TRUE)]
matching_path

df <- matching_path %>%
  map(read_data) %>%
  bind_rows()

avg_df <- df %>% group_by(sample_id) %>% mutate(meanG = mean(g), mean_f_b = mean(f_b))  %>% ungroup()

# Save outputs
saveRDS(df, file = here("data", paste0("data_cleaning_output", ".RDS")))
saveRDS(avg_df, file = here("data", paste0("data_cleaning_output_avg", ".RDS")))

