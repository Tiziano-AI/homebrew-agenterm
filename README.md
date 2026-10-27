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
that verified local source with pip, and exposes the `agenterm` command.
The installer requires Python 3.12.16 or newer in the Homebrew 3.12 family
and pip 26.2.2 or newer before any package downloads, following
[Python's emSign incident guidance](https://discuss.python.org/t/information-for-python-users-regarding-emudhra-emsign-ca-certificate-security-incident/109576).
Older Python runtimes and pip bundles can trust compromised certificates. Upgrade
Homebrew's `python@3.12` if this check fails; never disable TLS verification.

The same installation requires `litellm>=1.96.2` and `filelock>=4.2.1` to
exclude releases affected by published [LiteLLM Proxy
advisories](https://github.com/advisories/GHSA-3cv6-jpf6-8222) and
[filelock lock-file vulnerabilities](https://github.com/advisories/GHSA-v4x8-3wr5-3wq8).
These are minimum security versions, not a claim that every dependency or
Agenterm usage is free of vulnerabilities.

Agenterm 0.6.0 imports MCP's 1.x `McpError` API, so the installer also requires
`mcp<2`. MCP 2.x renamed that API and prevents this Agenterm release from
starting. This compatibility bound leaves patched MCP 1.x releases available.

Runtime and build dependencies are resolved from PyPI and are not hash-pinned
by this formula. The source checksum authenticates Agenterm's selected source
archive, not its entire dependency graph.

The formula's test checks `agenterm --help`; it is not an end-to-end model or
provider check. Published releases and package metadata are available on
[PyPI](https://pypi.org/project/agenterm/#history).

Run the installer regression harness without Homebrew installation or network
access with `ruby tests/installer_test.rb`.

## Remove

```bash
brew uninstall tiziano-ai/agenterm/agenterm
brew untap tiziano-ai/agenterm
```

These commands remove the Homebrew package and tap, not Homebrew itself.
Agenterm's user-created sessions and configuration may remain.
