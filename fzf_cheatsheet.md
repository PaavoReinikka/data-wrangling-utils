# fzf (Fuzzy Finder) Cheatsheet

`fzf` is an interactive Unix filter for command-line that can be used with any list; files, command history, processes, hostnames, bookmarks, git commits, etc.

### Basic Usage

Running `fzf` by itself starts a fuzzy finder in the current directory:
```bash
fzf
```

Open the selected file (nvim/vim):
```bash
vim $(fzf)
```

---

### Key Bindings (Standard Shell Integration)

If you have enabled shell integration (bash/zsh/fish), these shortcuts are available:

*   `CTRL-T`: Search for **files** and paste the selected path into the command line.
*   `CTRL-R`: Search through your **command history**.
*   `ALT-C`: Search for **directories** and `cd` into the selected one.

---

### Manually Emulating Shell Shortcuts

If you are not using shell integration, you can achieve similar effects manually:

*   **Emulate `CTRL-T`** (Paste path to command line):
    ```bash
    # Use fzf to result in a string you can use in another command
    cat $(fzf)
    ls -l $(fzf)
    ```
*   **Emulate `ALT-C`** (Change directory):
    ```bash
    # Find directories and pipe to fzf to select one to cd into
    cd $(find . -path '*/.*' -prune -o -type d -print | fzf)
    ```
*   **Emulate `CTRL-R`** (Paste from history):
    ```bash
    # Select from history and execute immediately
    eval $(history | fzf | sed 's/^[ ]*[0-9]*[ ]*//')
    ```

---

### Common Search & Filter Options

*   `-m`, `--multi`: Enable multi-select (using `TAB`).
    ```bash
    fzf -m
    ```
*   `--preview 'command'`: Show a preview of the selected item.
    ```bash
    # Preview files using 'cat' (or 'bat' if installed)
    fzf --preview 'cat {}'
    ```
*   `--query 'string'`: Start the finder with an initial search query.
    ```bash
    fzf --query ".conf"
    ```

---

### Combining with Other Tools

`fzf` works best when piped with other commands:

*   **Search through processes:**
    ```bash
    ps aux | fzf
    ```
*   **Search in command output:**
    ```bash
    ls -la | fzf
    ```
*   **Ripgrep integration (fast search):**
    ```bash
    rg --files | fzf
    ```

---

### Useful One-Liners

*   **Kill a process interactively:**
    ```bash
    ps -ef | fzf | awk '{print $2}' | xargs kill -9
    ```
*   **Switch Git branches:**
    ```bash
    git branch | fzf | xargs git checkout
    ```
*   **Jump to a directory (with preview):**
    ```bash
    find . -maxdepth 2 -type d | fzf --preview 'ls -F {}'
    ```

---

### Adding Custom Shortcuts to `.bashrc` or `.zshrc`

To make `fzf` even more powerful, you can add custom aliases and functions to your shell configuration file (e.g., `~/.bashrc`, `~/.zshrc`, or `~/.profile`).

#### 1. Quick Aliases
Add these for frequently used patterns:
```bash
# Preview files while finding (uses 'bat' if installed, otherwise 'cat')
alias fp="fzf --preview 'bat --color=always {} 2>/dev/null || cat {}'"

# Search and go to directory
alias fd='cd $(find . -maxdepth 3 -type d | fzf)'
```

#### 2. Shell Functions (Interactive Selection)
For more complex tasks, use functions:
```bash
# Interactive Git Checkout (Local Branches)
fco() {
  local branch
  branch=$(git branch | fzf) && git checkout $(echo "$branch" | tr -d ' *')
}

# Find hidden and normal files (excluding .git) and open in editor
fo() {
  IFS=$'\n' files=($(find . -maxdepth 3 -not -path '*/.*' -o -name '.git' -prune -o -type f -print | fzf -m))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}
```

#### 3. Custom Keybindings (using `bind`)
In Bash, you can bind specific keys to run `fzf` commands:
```bash
# Bind CTRL-F to search and write the file name to command line
bind '"\C-f":" \C-e\C-u $(fzf)\e\C-e\er"'
```

> **Tip:** Remember to run `source ~/.bashrc` (or restart your terminal) after saving these changes to apply them.
