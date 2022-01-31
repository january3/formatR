# A simple wrapper around the formatR package

Usage: ./formatR.R [options]


Options:
	-F, --force
		Force overwriting of existing files

	-m, --modify
		Modify the input file directly (ignored if -F is not set or if -o is used)

	-i INPUT, --input=INPUT
		Input file (default: stdin)

	-o OUTPUT, --output=OUTPUT
		Output file (default: stdout)

	--no_arrow
		Do not replace the assign operator ‘=’ with ‘<-’.

	--args_newline
		Start the arguments of a function call on a new line instead of after the
               function name and '(' when the arguments cannot fit one line (default: FALSE)

	-h, --help
		Show this help message and exit


Example usage:

  # The following are equivalent
  cat file.R | formatR.R > file_clean.R
  formatR.R -i file.R > file_clean.R
  formatR.R -i file.R -o file_clean.R
  
  # the last one modifies file.R in place
  formatR.R -i file.R -m -F

