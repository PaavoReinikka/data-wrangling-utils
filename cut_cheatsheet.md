# cut (Text Column Extraction) Cheatsheet

`cut` is a command-line utility for extracting sections from each line of input. It's ideal for working with delimited data (like CSV files), extracting specific columns, or slicing text by character or byte positions.

### Basic Syntax

The most common `cut` syntax involves specifying what to extract and from where:

```bash
cut [OPTIONS] [FILE]
```

*   **Extract from a file:**
    ```bash
    cut -f 1,3 data.csv
    ```
*   **Extract from piped input:**
    ```bash
    cat users.txt | cut -d: -f1
    ```

---

### Selection Methods

`cut` operates in one of three modes:

#### 1. Field Mode (`-f`): Extract Fields by Delimiter

Use this for delimited data (CSV, TSV, etc.). By default, the delimiter is TAB.

*   `-f`, `--fields=LIST`: Select only these fields.
    ```bash
    cut -f 1,3 data.txt # Extract fields 1 and 3
    ```

*   `-d`, `--delimiter=DELIM`: Use a custom delimiter (default is TAB).
    ```bash
    cut -d',' -f 2 data.csv # Extract 2nd field from CSV
    cut -d':' -f 1,6 /etc/passwd # Extract username and home directory
    ```

*   Field ranges:
    ```bash
    cut -f 1-3 data.txt      # Fields 1 through 3
    cut -f 1,3-5,7 data.txt  # Fields 1, 3 through 5, and 7
    cut -f 3- data.txt       # Field 3 to end of line
    cut -f -4 data.txt       # First 4 fields (1 through 4)
    ```

#### 2. Character Mode (`-c`): Extract Characters by Position

Use this to extract specific character positions from each line.

*   `-c`, `--characters=LIST`: Select only these characters.
    ```bash
    cut -c 1-5 file.txt      # Characters 1 through 5
    cut -c 10 file.txt       # Just the 10th character
    cut -c 1,5,10 file.txt   # Characters 1, 5, and 10
    cut -c 5- file.txt       # From character 5 to end of line
    cut -c -8 file.txt       # First 8 characters
    ```

#### 3. Byte Mode (`-b`): Extract Bytes by Position

Similar to character mode but operates on bytes (useful for multi-byte character encodings).

*   `-b`, `--bytes=LIST`: Select only these bytes.
    ```bash
    cut -b 1-10 file.txt # First 10 bytes
    ```

---

### Common Options

*   `--complement`: Invert the selection (select everything *except* the specified fields/characters).
    ```bash
    cut -d',' -f 2 --complement data.csv # All fields except the 2nd
    ```

*   `-s`, `--only-delimited`: Don't print lines that don't contain the delimiter (field mode only).
    ```bash
    cut -d',' -f 1 -s data.csv # Skip lines without commas
    ```

*   `--output-delimiter=STRING`: Use a custom output delimiter (field mode only).
    ```bash
    # Convert comma-separated to pipe-separated
    cut -d',' -f 1,2,3 --output-delimiter='|' data.csv
    ```

---

### Examples

*   **Extract usernames from `/etc/passwd` (1st field, `:` delimiter):**
    ```bash
    cut -d':' -f1 /etc/passwd
    ```

*   **Extract the 2nd and 4th columns from a CSV file:**
    ```bash
    cut -d',' -f2,4 data.csv
    ```

*   **Get the first 20 characters of each line:**
    ```bash
    cut -c 1-20 longlines.txt
    ```

*   **Extract all fields except the 3rd from a tab-delimited file:**
    ```bash
    cut -f 3 --complement data.tsv
    ```

*   **Extract email domains from a list (everything after `@`):**
    ```bash
    # This requires preprocessing since cut can't easily handle "after delimiter"
    cut -d'@' -f2 emails.txt
    ```

*   **Convert CSV to TSV (comma to tab):**
    ```bash
    cut -d',' -f 1- --output-delimiter=$'\t' data.csv
    ```

*   **Extract username and home directory from `/etc/passwd`, output as pipe-separated:**
    ```bash
    cut -d':' -f 1,6 --output-delimiter='|' /etc/passwd
    ```

*   **Process output from `ps` command to get only PID and command:**
    ```bash
    ps aux | tr -s ' ' | cut -d' ' -f 2,11
    ```

---

### Tips & Tricks

*   **`cut` doesn't support reordering fields.** If you need to reorder, use `awk` instead:
    ```bash
    awk -F',' '{print $3, $1}' data.csv  # Print field 3, then field 1
    ```

*   **`cut` can't extract "last field" directly.** Use `rev` to reverse lines, extract the first field, then reverse again:
    ```bash
    rev file.txt | cut -d',' -f1 | rev  # Get last comma-separated field
    ```
    Or use `awk`:
    ```bash
    awk -F',' '{print $NF}' file.txt  # Print last field
    ```

*   **Combine with other tools** for powerful text processing pipelines:
    ```bash
    # Extract unique usernames and sort them
    cut -d':' -f1 /etc/passwd | sort | uniq
    
    # Count unique values in column 3 of a CSV
    cut -d',' -f3 data.csv | sort | uniq -c
    ```

*   **Handle spaces as delimiters carefully.** If you have multiple consecutive spaces, normalize them first with `tr`:
    ```bash
    cat file.txt | tr -s ' ' | cut -d' ' -f2
    ```
