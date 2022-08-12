defmodule UnCLI.Client do
  @moduledoc false

  alias UnCLI.{Output}
  alias UnCLI.{Accounts, Sources}

  def call(args) do
    case args do
      ["account", "create"] ->
        Accounts.create()

      ["sources", "add"] ->
        Sources.add()

      ["sources", "list"] ->
        Sources.list()

      ["sources", "remove", url] ->
        Sources.remove(url)

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

    Output.Help.items("Core commands", ["account", "auth", "feed", "sources", "entries"])

    Output.Help.items("Subcommands", [
      {"account create", "creates a new account"},
      {"auth login", "configures current authenticated account"},
      {"sources add", "adds a new source"},
      {"sources list", "list all sources in the authenticated account"},
      {"entries list", "lists all downloaded entries in the authenticated account"},
      {"feeds pull", "downloads all new entries from the sources in the authenticated account"}
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
    Output.empty()
    Output.error("Invalid arguments provided.")
    Output.put("Try --help for an overview of all commands")
  end
end
