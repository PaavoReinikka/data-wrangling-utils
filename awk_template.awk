#!/usr/bin/awk -f

# AWK Script Template
# Usage: awk -f script.awk input.txt
# or: ./script.awk input.txt (if executable)

# =============================================================================
# BEGIN BLOCK - Executes once before processing any input
# =============================================================================
BEGIN {
    # Set field separator (default is whitespace)
    FS = ","           # For CSV files
    # FS = "\t"        # For tab-separated files
    # FS = ":"         # For colon-separated files (like /etc/passwd)
    
    # Set output field separator (default is single space)
    OFS = ","          # Output fields separated by comma
    
    # Set record separator (default is newline)
    # RS = "\n"        # Default - one line per record
    # RS = ""          # Paragraph mode - blank lines separate records
    
    # Set output record separator (default is newline)
    ORS = "\n"
    
    # Initialize variables
    total = 0
    count = 0
    max = 0
    
    # Print header
    print "Processing started..."
    # printf "%-20s %-10s %-10s\n", "Name", "Value", "Status"
}

# =============================================================================
# PATTERN-ACTION BLOCKS - Execute for each input line/record
# =============================================================================

# Skip header line (line number 1)
NR == 1 {
    next  # Skip to next record without executing remaining blocks
}

# Skip empty lines
/^$/ {
    next
}

# Skip comment lines starting with #
/^#/ {
    next
}

# Match specific pattern and perform action
# Example: lines containing "ERROR"
/ERROR/ {
    print "Error found on line", NR ":", $0
    error_count++
}

# Match pattern with case-insensitive search
# IGNORECASE = 1  # Uncomment to enable case-insensitive matching
toupper($0) ~ /WARNING/ {
    print "Warning on line", NR
}

# Conditional processing based on field values
# Example: If first field equals "active"
$1 == "active" {
    active_count++
    # $1, $2, $3 ... represent fields in current record
    # $0 represents entire record
    print "Active item:", $2
}

# Numeric comparison on fields
# Example: If third field is greater than 100
$3 > 100 {
    print "High value:", $3, "in record", NR
}

# Multiple conditions with AND (&&) or OR (||)
$1 == "active" && $3 > 50 {
    print "Active with high value:", $0
}

# Range pattern - execute for records between two patterns
/START/, /END/ {
    print "In range:", $0
}

# Pattern with regular expression
# Match lines with email addresses
/[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+/ {
    print "Email found:", $0
}

# Main processing block (no pattern = matches all lines)
{
    # Built-in variables:
    # NR  = Current record number (line number across all files)
    # FNR = Record number in current file
    # NF  = Number of fields in current record
    # FILENAME = Name of current input file
    
    # Access fields: $1 is first field, $2 is second, etc.
    # $0 is the entire line
    
    # Example: Sum values in third column
    if (NF >= 3 && $3 ~ /^[0-9]+$/) {  # Check if field 3 is numeric
        total += $3
        count++
        
        # Track maximum value
        if ($3 > max) {
            max = $3
        }
    }
    
    # String operations
    # length($1)           # Length of field 1
    # substr($1, 1, 5)     # Substring of field 1
    # tolower($1)          # Convert to lowercase
    # toupper($1)          # Convert to uppercase
    # gsub(/old/, "new")   # Replace all occurrences in $0
    # sub(/old/, "new")    # Replace first occurrence in $0
    # split($0, arr, ",")  # Split $0 into array arr using comma
    
    # Arrays (associative)
    # count_by_type[$1]++
    # values[$1] = $2
}

# =============================================================================
# END BLOCK - Executes once after all input is processed
# =============================================================================
END {
    # Print summary statistics
    print "\nProcessing complete!"
    print "-------------------"
    print "Total records processed:", NR
    print "Total count:", count
    print "Sum:", total
    
    if (count > 0) {
        print "Average:", total / count
        print "Maximum:", max
    }
    
    # Print array contents
    # for (key in array_name) {
    #     print key, array_name[key]
    # }
    
    # Exit with status code
    # exit 0  # Success
    # exit 1  # Error
}

# =============================================================================
# COMMON AWK FUNCTIONS
# =============================================================================
# Mathematical: sin(), cos(), atan2(), exp(), log(), sqrt(), int(), rand(), srand()
# String: length(), substr(), index(), tolower(), toupper(), split(), sub(), gsub()
# I/O: print, printf, getline
# System: system("command")

# =============================================================================
# USAGE EXAMPLES
# =============================================================================
# Process CSV file and print second column:
#   awk -F',' '{print $2}' file.csv
#
# Sum numbers in first column:
#   awk '{sum += $1} END {print sum}' numbers.txt
#
# Print lines longer than 80 characters:
#   awk 'length($0) > 80' file.txt
#
# Print specific fields with custom output:
#   awk '{printf "%-10s %5d\n", $1, $2}' file.txt
#
# Count occurrences:
#   awk '{count[$1]++} END {for (word in count) print word, count[word]}' file.txt
