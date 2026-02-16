# grep (Global Regular Expression Print) Cheatsheet

`grep` is a powerful command-line utility for searching plain-text data sets for lines that match a regular expression. It's invaluable for filtering logs, finding code, and generally searching through text files.

### Basic Syntax

The most common `grep` syntax involves a pattern to search for and the file(s) to search in:

```bash
grep 'pattern' filename
```

*   **Search in multiple files:**
    ```bash
    grep 'pattern' file1.txt file2.txt
    ```
*   **Search output from another command (piping):**
    ```bash
    ps aux | grep 'process_name'
    ```

---

### Common Options

`grep` has many useful options to refine your searches:

*   `-i`, `--ignore-case`: Ignore case distinctions in patterns and input data.
    ```bash
    grep -i 'error' log.txt # Matches "error", "Error", "ERROR", etc.
    ```

*   `-v`, `--invert-match`: Invert the sense of matching, to select non-matching lines.
    ```bash
    grep -v 'DEBUG' log.txt # Show lines that do NOT contain "DEBUG"
    ```

*   `-r`, `--recursive` / `-R`, `--dereference-recursive`: Search directories recursively. `-R` follows symbolic links.
    ```bash
    grep -r 'TODO' ./src/ # Find "TODO" in all files under src/
    ```

*   `-l`, `--files-with-matches`: Suppress normal output; instead print the name of each input file from which output would normally have been printed.
    ```bash
    grep -l 'main()' *.c # List only the .c files that contain "main()"
    ```

*   `-n`, `--line-number`: Prefix each line of output with the 1-based line number within its input file.
    ```bash
    grep -n 'warning' build.log
    ```

*   `-c`, `--count`: Suppress normal output; instead print a count of matching lines for each input file.
    ```bash
    grep -c 'Failed' server.log # Count how many lines contain "Failed"
    ```

*   `-w`, `--word-regexp`: Select only those lines containing matches that form whole words.
    ```bash
    grep -w 'run' script.sh # Matches "run" but not "running" or "runner"
    ```

*   `-A NUM`, `--after-context=NUM`: Print `NUM` lines of trailing context after matching lines.
*   `-B NUM`, `--before-context=NUM`: Print `NUM` lines of leading context before matching lines.
*   `-C NUM`, `--context=NUM`: Print `NUM` lines of context around matching lines (same as `-A NUM -B NUM`).
    ```bash
    grep -A 3 'function init' code.js # Show 3 lines after "function init"
    ```

*   `-E`, `--extended-regexp` (`egrep`): Interpret PATTERN as an extended regular expression (ERE).
    ```bash
    grep -E '^(Error|Warning)' log.txt # Lines starting with "Error" OR "Warning"
    ```

*   `-F`, `--fixed-strings` (`fgrep`): Interpret PATTERN as a list of fixed strings, separated by newlines, any of which is to be matched. Much faster for exact string searches.
    ```bash
    grep -F 'exact_string' config.ini
    ```

*   `-o`, `--only-matching`: Print only the matched (non-empty) parts of a matching line, with each such part on a separate output line.
    ```bash
    grep -o '[0-9]{3}-[0-9]{3}-[0-9]{4}' contacts.txt # Extract phone numbers
    ```

---

### Regular Expressions (Brief Overview)

`grep` uses regular expressions to define patterns. By default, it uses Basic Regular Expressions (BRE). With `-E`, it uses Extended Regular Expressions (ERE), which offer more features without needing to escape special characters.

*   `.`: Matches any single character (except newline).
*   `*`: Matches zero or more occurrences of the preceding character or group.
*   `+`: Matches one or more occurrences of the preceding character or group (requires `-E`).
*   `?`: Matches zero or one occurrence of the preceding character or group (requires `-E`).
*   `^`: Matches the beginning of a line.
*   `$`: Matches the end of a line.
*   `[abc]`: Matches any one of the characters inside the brackets (e.g., `a`, `b`, or `c`).
*   `[a-z]`: Matches any character in the range (e.g., any lowercase letter).
*   `[^abc]`: Matches any character *not* inside the brackets.
*   `\b`: Matches a word boundary (useful with `-w`).
*   `\(` `\)`: Grouping (for BRE); use `(` `)` directly with `-E`.
*   `|`: OR operator (requires `-E`). E.g., `(cat|dog)`.
*   `{n}`: Matches exactly `n` occurrences (requires `-E`). E.g., `a{3}` for `aaa`.
*   `{n,}`: Matches `n` or more occurrences (requires `-E`).
*   `{n,m}`: Matches between `n` and `m` occurrences (requires `-E`).

---

### Examples

*   **Find "error" (case-insensitive) in `app.log`:**
    ```bash
    grep -i 'error' app.log
    ```

*   **Find lines that do NOT contain "INFO" in `sys.log`:**
    ```bash
    grep -v 'INFO' sys.log
    ```

*   **Recursively find "import React" in `.js` files, showing filenames and line numbers:**
    ```bash
    grep -rn 'import React' *.js
    ```

*   **Count the number of times "SUCCESS" appears in `status.log`:**
    ```bash
    grep -c 'SUCCESS' status.log
    ```

*   **Find "password" as a whole word and show 2 lines of context around it:**
    ```bash
    grep -C 2 -w 'password' config.txt
    ```

*   **Extract all email addresses from `contacts.txt`:**
    ```bash
    grep -E -o '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b' contacts.txt
    ```
