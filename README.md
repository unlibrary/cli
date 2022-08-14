# Unlibrary CLI

aka `UnCLI`

## Installation

```shell
git clone https://github.com/unlibrary/cli
cd cli
mix deps.get
mix escript.build
```

This will produce a binary named `uncli` in your working directory.

[readerd](https://github.com/unlibrary/readerd) is required as backend for uncli.

## Usage

```shell
$  uncli --help
uncli v0.1.0
a rss reader cli for unix systems built using elixir and erlang.

USAGE:
    uncli <command> <subcommand> [flags]

CORE COMMANDS:
    accounts
    auth
    sources
    entries
    feeds

SUBCOMMANDS:
    accounts create
        creates a new account

    auth login
        configures current authenticated account

    sources add
        adds a new source

    sources list
        list all sources in the authenticated account

    sources remove <url>
        removes a source (use list to get url)

    entries list
        lists all downloaded entries in the authenticated account

    entries read <id>
        renders entry (use list to get id)

    entries prune
        deletes all downloaded entries

    feeds pull
        downloads the 5 newest entries (skips entries that are already downloaded) from the sources in the authenticated account


FLAGS:
    --help, -h
        show these instructions

    --version, -v
        show uncli version


Read the full manual at https://unlibrary.github.io/cli/
```
