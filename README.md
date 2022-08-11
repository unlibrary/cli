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

## Usage

```shell
$  uncli --help
uncli 0.1.0
a rss reader cli for unix systems built using elixir and erlang.

USAGE:
    uncli <command> <subcommand> [flags]

CORE COMMANDS:
    account
    auth
    feeds
    source
    entries

SUBCOMMANDS:
    account create --username <string> --password <string>
        creates a new account
        accounts are on-device buckets of sources, i 
        do not collect any data

    auth login --username <string> --password <string>
        configures current authenticated account

    auth logout
        clears current authenticated account
    
    source create --url <string> --title <string> --type <type>
        adds a new source
        possible types are: rss, atom, mf2

    source list
        list all sources in the authenticated account

    entries list
        lists all downloaded entries in the authenticated account

    entries list --source <id>
        lists all downloaded entries for a source

    entries show --entry <id>
        shows the chosen entry with $PAGER

    entries show --all
        shows all entries with $PAGER

    feeds pull
        downloads all new entries from the sources in the authenticated account

FLAGS:
    --help, -h
        Show these instructions

    --version, -v
        Show uncli version
    
LEARN MORE
Read the full manual at https://unlibrary.github.io/cli/

```
