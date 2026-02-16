# (g)awk (Pattern Scanning and Processing Language) Cheatsheet

`awk` is a versatile programming language designed for text processing and data extraction. It excels at handle tabular data and records, as it automatically splits lines into fields.

### Basic Syntax

The core of `awk` is the pattern-action paradigm:
```bash
awk 'pattern { action }' input_file
```
*   **Piping from another command:**
    ```bash
    ls -l | awk '{ print $9, $5 }' # Print filename and size
    ```
---

### Standard Structure

`awk` scripts often use two special patterns: `BEGIN` and `END`.

*   **`BEGIN { ... }`**: Executed **before** any input lines are read (useful for initializing variables or changing separators).
*   **`{ ... }`**: General action block, executed for **every** line that matches the pattern (if no pattern is provided, it runs for every line).
*   **`END { ... }`**: Executed **after** all input lines have been processed (useful for summary stats).

```bash
# Example: Count lines in a file
awk 'BEGIN { count=0 } { count++ } END { print count }' file.txt
```

---

### Built-in Variables

AWK manages several variables automatically:

*   **`$0`**: The entire current input record (line).
*   **`$1`, `$2`, `$n`**: The first, second, or n-th field of the current record.
*   **`NF`**: Number of Fields in the current record.
*   **`NR`**: Number of Records (line number) globally across all input files.
*   **`FNR`**: Number of Records (line number) relative to the current file.
*   **`FS`**: Field Separator (default is whitespace).
*   **`RS`**: Record Separator (default is newline).
*   **`OFS`**: Output Field Separator (default is space).
*   **`ORS`**: Output Record Separator (default is newline).

---

### Patterns and Addressing

*   **Regular Expression Match**:
    ```bash
    awk '/ERROR/ { print $0 }' log.txt # Print lines containing "ERROR"
    ```
*   **Invert Match**:
    ```bash
    awk '!/DEBUG/ { print $0 }' log.txt # Print lines NOT containing "DEBUG"
    ```
*   **Field Comparison**:
    ```bash
    awk '$3 > 100 { print $1 }' data.csv # Print 1st field if 3rd field > 100
    ```
*   **Range of Lines**:
    ```bash
    awk 'NR==10, NR==20' file.txt # Print lines 10 through 20
    ```

---

### Common Options

*   `-F 'sep'`: Define the input field separator (e.g., `-F ','` for CSV).
*   `-v var=value`: Pass an external variable into the `awk` script.
    ```bash
    limit=50
    awk -v lim=$limit '$3 > lim' data.txt
    ```
*   `-f scriptfile`: Run `awk` commands from a file.

---

### Functions and Control Flow

#### 1. String Functions
*   `length($0)`: Returns length of string.
*   `substr(string, start, length)`: Extracts a substring.
*   `tolower(string)`, `toupper(string)`: Case conversion.
*   `split(string, array, separator)`: Splits string into an array.
*   `gsub(regex, replacement, target)`: Global substitution (like `sed 's///g'`).

#### 2. Flow Control
```awk
# Conditional execution
awk '{ if ($3 > 100) print "High"; else print "Low" }'

# Loops
awk '{ for (i=1; i<=NF; i++) print $i }' # Print every field on its own line
```

---

### Famous One-Liners

*   **Sum the third column:**
    ```bash
    awk '{ sum += $3 } END { print sum }' data.txt
    ```
*   **Print only even lines:**
    ```bash
    awk 'NR % 2 == 0' file.txt
    ```
*   **Remove duplicate lines (like `uniq` but without sorting):**
    ```bash
    awk '!visited[$0]++' file.txt
    ```
*   **Print the last field of every line:**
    ```bash
    awk '{ print $NF }' file.txt
    ```
