cat data.txt | awk 'BEGIN { FS = "," } {print substr($1,3) "\t" substr($2,2,3) }' > data.for

