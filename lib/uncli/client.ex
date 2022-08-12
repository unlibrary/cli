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

      _ ->
        invalid_arguments()
    end
  end

  defp invalid_arguments do
    Output.empty()
    Output.error("Invalid arguments provided.")
    Output.put("Try --help for an overview of all commands")
  end
end
