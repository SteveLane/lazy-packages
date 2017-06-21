#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly = TRUE)
################################################################################
################################################################################
## Title: ipak
## Author: Steve Lane
## Date: Wednesday, 21 June 2017
## Synopsis: Script to test for installed packages, and if not installed,
## install them.
## Time-stamp: <2017-06-21 14:46:27 (slane)>
################################################################################
################################################################################
if(!(length(args) %in% 1:2)){
    stop("A single argument is required to be passed to ipak.R: insts.\ninsts is the file location of a newline separated list of required packages.\nYou can also pass in repos, which is the repository you want to install from.\nExample: Rscript ipak.R insts=../installs.txt repos='https://cran.csiro.au/'",
         call. = FALSE)
} else {
    if(length(args) == 1)
        repos <- "https://cran.csiro.au/"
    }
    hasOpt <- grepl("=", args)
    argLocal <- strsplit(args[hasOpt], "=")
    for(i in seq_along(argLocal)){
        value <- NA
        tryCatch(value <- as.double(argLocal[[i]][2]), warning = function(e){})
        if(!is.na(value)){
            ## Assume int/double
            assign(argLocal[[i]][1], value, inherits = TRUE)
        } else {
            assign(argLocal[[i]][1], argLocal[[i]][2], inherits = TRUE)
        }
    }
}
pkg <- scan(insts, "character")
new.pkgs <- pkg[!(pkg %in% installed.packages()[, "Package"])]
if(!(length(new.pkgs) == 0)){
    install.packages(new.pkgs, dependencies = TRUE, repos = repos)
}
