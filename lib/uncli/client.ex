defmodule UnCLI.Client do
  @moduledoc false

  alias UnCLI.{Output}
  alias UnCLI.{Auth, Accounts, Sources, Entries, Feeds}

  def call(args) do
    case args do
      ["auth", "login"] ->
        Auth.login()

      ["auth", "logout"] ->
        Auth.logout()

      ["accounts", "create"] ->
        Accounts.create()

      ["sources", "add"] ->
        Sources.add()

      ["sources", "list"] ->
        Sources.list()

      ["sources", "remove", url] ->
        Sources.remove(url)

      ["entries", "list"] ->
        Entries.list()

      ["entries", "read", url] ->
        Entries.read(url)

      ["feeds", "pull"] ->
        Feeds.pull()

      ["feeds", "download"] ->
        Feeds.pull()

      ["feeds", "prune"] ->
        Feeds.prune(:read)

      ["feeds", "prune", "--all"] ->
        Feeds.prune(:all)

      [h] when h in ["--help", "-h"] ->
        help()

      [v] when v in ["--version", "-v"] ->
        version()

      _ ->
        invalid_arguments()
    end
  end

  defp help do
    Output.Help.header(
      "uncli",
      "a rss reader cli for unix systems built using elixir and erlang."
    )

    Output.Help.items("Usage", ["uncli <command> <subcommand> [flags]"])

    Output.Help.items("Core commands", ["accounts", "auth", "sources", "entries", "feeds"])

    Output.Help.items("Subcommands", [
      {"accounts create", "creates a new account"},
      {"auth login", "configures current authenticated account"},
      {"sources add", "adds a new source"},
      {"sources list", "list all sources in the authenticated account"},
      {"sources remove <url>", "removes a source (use list to get url)"},
      {"entries list", "lists all downloaded entries in the authenticated account"},
      {"entries read <id>", "renders entry (use list to get id)"},
      {"feeds download",
       "downloads the 5 newest entries (skips entries that are already downloaded) from the sources in the authenticated account"},
      {"feeds prune [opts]", "deletes read entries, use --all to delete all downloaded entries"}
    ])

    Output.Help.items("Flags", [
      {"--help, -h", "show these instructions"},
      {"--version, -v", "show uncli version"}
    ])

    Output.put("Read the full manual at https://unlibrary.github.io/cli/")
  end

  defp version do
    Output.Help.header(
      "uncli",
      "a rss reader cli for unix systems built using elixir and erlang."
    )
  end

  defp invalid_arguments do
    Output.error("Invalid arguments provided.")
    Output.put("Try --help for an overview of all commands")
  end
end
