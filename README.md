# data-wrangling-utils

A collection of cheatsheets, scripts, and utilities for text processing, data extraction, and general data manipulation.

This repository serves as a personal reference and a landing spot for custom-built tools designed to make working with data on the command line more efficient.

## 📂 Contents

### 📝 Cheatsheets: The "Holy Trinity" + plus Fuzzy Finder
Handy references for the classic Unix text processing tools:
*   [grep_cheatsheet.md](grep_cheatsheet.md) - Pattern searching with Regular Expressions.
*   [sed_cheatsheet.md](sed_cheatsheet.md) - Stream editing and text transformations.
*   [awk_cheatsheet.md](awk_cheatsheet.md) - Pattern scanning and field-based processing.
*   [fzf_cheatsheet.md](fzf_cheatsheet.md) - Fuzzy finder for files, history, and more.

### 🛠️ Utilities (Coming Soon)
Work-in-progress implementations of more complex wrangling tasks in various languages:
*   **Python**: For data analysis and scripting.
*   **Go**: For high-performance CLI tools.
*   **Haskell**: For robust, functional data transformations.
*   **AWK**: Custom scripts for specific recurring reports/logs/etc.

## 🚀 Usage

Most of the current documentation is geared towards standard Unix environments. If you are on Windows, these tools are generally available via:
*   [Git Bash](https://git-scm.com/downloads)
*   [WSL (Windows Subsystem for Linux)](https://learn.microsoft.com/en-us/windows/wsl/install)
*   [GnuWin32](http://gnuwin32.sourceforge.net/)

**NOTE:** Nowadays you can also use `choco` and other package managers to install bash tools on windows. Directly in powershell (recommended pwsh>=7.5):

```pwsh
choco install grep sed gawk
```

*Fuzzy might be tricky to get to work on windows, but very simple on linux/unix.*

To enable `fzf` shell integration (bash/zsh), run the install script after installation:
```bash
$(brew --prefix)/opt/fzf/install
# OR
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
```

## 📈 Roadmap

- [x] Initial Unix tool cheatsheets.
- [ ] Build a log parser in Go.
- [ ] Add functional data processing examples in Haskell.
