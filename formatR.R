#!/usr/bin/env Rscript
library(optparse)
library(formatR)


option_list <- list(
  make_option(c('-F', '--force'), action="store_true",
              default=FALSE,
              help="Force overwriting of existing files"),
  make_option(c('-m', '--modify'), action="store_true",
              default=FALSE,
              help="Modify the input file directly (ignored if -F is not set or if -o is used)"),
  make_option(c('-i', '--input'), action="store",
              help="Input file (default: stdin)"),
  make_option(c('-o', '--output'), action="store",
              help="Output file (default: stdout)"),
  make_option(c('--no_arrow'), action="store_true", 
              default=FALSE, help=
"Do not replace the assign operator ‘=’ with ‘<-’."),
  make_option(c('--args_newline'), action="store_true", 
              default=FALSE, help=
                "Start the arguments of a function call on a new line instead of after the
               function name and '(' when the arguments cannot fit one line (default: FALSE)")
)

opt_parser <- OptionParser(option_list=option_list,
  epilogue="
Example usage:

  # The following are equivalent
  cat file.R | formatR.R > file_clean.R
  formatR.R -i file.R > file_clean.R
  formatR.R -i file.R -o file_clean.R
  
  # the last one modifies file.R in place
  formatR.R -i file.R -m -F
")
opt <- parse_args(opt_parser)

## determine input file

if(is.null(opt$input)) {
  f <- file("stdin")
} else {
  if(!file.exists(opt$input)) {
    stop(sprintf("File %s does not exist", opt$input))
  }
  f <- file(opt$input, "r")
}

lines <- readLines(f)
close(f)

## determine output file
if(is.null(opt$output) && opt$modify) {
  if(is.null(opt$input)) {
    stop("The option -m requires an argument to option -i")
  }
  opt$output <- opt$input
}

if(!is.null(opt$output)) {
  if(file.exists(opt$output)) {
    if(!opt$force) {
      stop("Cowardly refusing to overwrite existing file (use -F to force)")
    } else {
      warning("Overwriting existing file")
    }
  }
} 
 
if(is.null(opt$output)) {
  opt$output <- ""
} 

foo <- tidy_source(text = lines, arrow=!opt$no_arrow, file=opt$output)






