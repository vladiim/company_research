# source('init.r')

# ----------- # # ----------- # # ----------- #
# DEPENDENCIES

suppressMessages(local({
  library(reshape)
  library(knitr)
  library(markdown)
  library(ggplot2)
  library(scales)
  library(dplyr)
  library(RColorBrewer)
  library(xts)
  library(XML)
}))

# ----------- # # ----------- # # ----------- #
# SET UP

# helper functions

loadDir <- function(dir) {
  if (file.exists(dir)) {
    files <- dir(dir , pattern = '[.][rR]$')
    lapply(files, function(file) loadFile(file, dir))
  }
}

loadFile <- function(file, dir) {
  filename <- paste0(dir, '/', file)
  source(filename)
}

setReportingWd <- function() {
  if(basename(getwd()) == 'templates') {
    setwd('../../')
  }
}

knitrGlobalConfig <- function() {
  opts_chunk$set(fig.width = 14, fig.height = 6,
    fig.path = paste0(getwd(), '/reports/output/figures/',
    set_comment = NA))
}

setEnvVars <- function() {
  source('env.R')
}

# Config env
setReportingWd()
knitrGlobalConfig()
# setEnvVars() if you have env vars

ASX_FIN_SERVICES <- data.frame(
  ticker = c('CBA', 'WBC', 'NAB', 'ANZ', 'BEN', 'BOQ', 'SUN', 'AMP', 'MQG'),
  name   = c('Commonwealth Bank', 'Westpac Banking Corp', 'National Australia Bank', 'Australia and New Zealand Banking Group', 'Bendigo and Adelaide Bank Ltd', 'Bank of Queensland Limited', 'Suncorp Group Ltd', 'AMP Limited', 'Macquarie Group Ltd')
)

# Load code
dirs <- c('extract', 'load', 'transform', 'plots', 'lib', 'models')
lapply(dirs, loadDir)
source('./reports/run.R')

# No scientific notation
options(scipen = 999)
