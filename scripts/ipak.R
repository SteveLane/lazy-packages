#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly = TRUE)
################################################################################
################################################################################
## Title: ipak
## Author: Steve Lane
## Date: Wednesday, 21 June 2017
## Synopsis: Script to test for installed packages, and if not installed,
## install them.
## Time-stamp: <2017-06-21 12:14:21 (slane)>
################################################################################
################################################################################
if(!(length(args) == 1)){
    stop("A single argument must be passed to ipak.R: insts.\ninsts is the location of a newline separated list of required packages.\nExample: Rscript ipak.R insts=../installs.txt",
         call. = FALSE)
} else {
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
## Check for github packages (throw away github username)
chk.git <- gsub(".*/", "", pkg)    
new.pkg <- pkg[!(chk.git %in% installed.packages()[, "Package"])]
if(!(length(new.pkg) == 0)){
    git.ind <- grep("/", new.pkg)
    if(length(git.ind) == 0){
        install.packages(new.pkg, dependencies = TRUE,
                         repos = "https://cran.csiro.au/")
    } else {
        devtools::install_github(new.pkg[git.ind])
    }
}
