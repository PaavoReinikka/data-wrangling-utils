# sed (Stream Editor) Cheatsheet

`sed` is a powerful command-line utility for parsing and transforming text. It operates on a stream of text and is great for find-and-replace operations, text normalization, and other transformations.

### Basic Syntax

The most common `sed` syntax is:
```bash
sed 'COMMAND' input_file.txt
```
By default, `sed` prints the result to standard output. To save the changes to a file, you can use output redirection:
```bash
sed 'COMMAND' input_file.txt > output_file.txt
```

---

### Key Commands and Concepts

#### 1. Substitution: `s/pattern/replacement/flags`

This is the most common command. It finds a `pattern` (regular expression) and replaces it with the `replacement` string.

*   **Example:** Replace the first occurrence of `old` with `new` on each line.
    ```bash
    sed 's/old/new/' file.txt
    ```

*   **Flags:**
    *   `g` (global): Replace **all** occurrences on the line, not just the first.
        ```bash
        sed 's/old/new/g' file.txt
        ```
    *   `i` (case-insensitive): Match the pattern regardless of case (GNU `sed` extension).
        ```bash
        sed 's/Old/new/gi' file.txt
        ```
    *   **Numbered occurrence**: Replace only the Nth occurrence on a line.
        ```bash
        # Replaces only the 2nd occurrence of 'old'
        sed 's/old/new/2' file.txt
        ```

#### 2. Limiting to Specific Lines (Addressing)

You can specify a line number or a pattern to limit which lines the command runs on.

*   **Single Line Number:** Apply the command only to line `N`.
    ```bash
    # Replace 'old' with 'new' only on line 3
    sed '3s/old/new/g' file.txt
    ```

*   **Range of Lines:** Apply the command from line `M` to `N`.
    ```bash
    # Apply the substitution from line 1 to 5
    sed '1,5s/old/new/g' file.txt
    ```

*   **Pattern Matching:** Apply the command only to lines containing `find_me`.
    ```bash
    sed '/find_me/s/old/new/g' file.txt
    ```

*   **Last Line (`$`):**
    ```bash
    # Apply only to the last line of the file
    sed '$s/old/new/g' file.txt
    ```

#### 3. Deleting Lines: `d`

The `d` command deletes lines.

*   **Delete a specific line:**
    ```bash
    # Delete line 5
    sed '5d' file.txt
    ```

*   **Delete a range of lines:**
    ```bash
    # Delete lines 5 through 10
    sed '5,10d' file.txt
    ```

*   **Delete lines matching a pattern:**
    ```bash
    # Delete all lines containing the word 'ERROR'
    sed '/ERROR/d' file.txt
    ```

#### 4. In-Place Editing: `-i`

To modify the file directly instead of printing to standard output, use the `-i` flag. **Use with caution!**

*   **Modify the file directly (no backup):**
    ```bash
    sed -i 's/old/new/g' file.txt
    ```

*   **Modify the file and create a backup (`.bak`):**
    ```bash
    sed -i.bak 's/old/new/g' file.txt
    # Original file is now file.txt.bak
    ```

#### 5. Printing Lines: `p` with `-n`

By default, `sed` prints every line after processing. The `-n` flag suppresses this default output. The `p` command then tells `sed` to explicitly print a line. This combination is useful for filtering.

*   **Print only lines that match a pattern (like `grep`):**
    ```bash
    sed -n '/pattern/p' file.txt
    ```

---
