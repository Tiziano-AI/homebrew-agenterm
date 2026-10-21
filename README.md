# Agenterm Homebrew tap

Install [Agenterm](https://pypi.org/project/agenterm/) with Homebrew.
Agenterm is a terminal-native agent runtime with persistent sessions,
branching and MCP support. This repository contains its Homebrew formula,
not the application source.

## Install

You need [Homebrew](https://brew.sh/). Add the tap, then install the fully
qualified formula:

```bash
brew tap tiziano-ai/agenterm
brew install tiziano-ai/agenterm/agenterm
agenterm --help
```

Homebrew installs the formula's declared dependencies: Python 3.12,
`ripgrep`, `fd`, `bat` and `tree`. You do not need to prepare a separate
Python environment or install pip yourself.

Use [Agenterm's package page](https://pypi.org/project/agenterm/) for product
usage and configuration. This tap handles installation; it does not configure
model providers or credentials.

## Package and source

[`Formula/agenterm.rb`](Formula/agenterm.rb) is the packaging source of truth.
It selects a versioned PyPI source archive and its SHA-256, creates a dedicated
Python 3.12 virtual environment, installs the matching Agenterm release from
PyPI with pip, and exposes the `agenterm` command.

The formula's test checks `agenterm --help`; it is not an end-to-end model or
provider check. Published releases and package metadata are available on
[PyPI](https://pypi.org/project/agenterm/#history).

## Remove

```bash
brew uninstall tiziano-ai/agenterm/agenterm
brew untap tiziano-ai/agenterm
```

These commands remove the Homebrew package and tap, not Homebrew itself.
Agenterm's user-created sessions and configuration may remain.
