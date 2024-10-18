library(here)
library(tidyverse)
library(readxl)
library(plater)
library(janitor)

source(here("R", "functions.R"))

############################
# download DRC data from dropbox
############################
db_dest <- here("data", "dropbox")
dropbox_downloader("https://www.dropbox.com/scl/fo/l1ccs9j283ztkarf5mdbu/AH7U_kik_o6f80hoqlISTqU?rlkey=pb2dt7gclk5yr0y5zrk94tiwv&dl=1", db_dest)

############################
# import  data
############################
#list all files you copied over from dropbox
all_paths <- list.files(file.path(db_dest, "unzipped"), recursive = TRUE, full.names = TRUE)
df <- all_paths %>%
  map(read_data) %>%
  bind_rows()

