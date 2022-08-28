defmodule UnCLI.Feeds do
  @moduledoc false

  alias UnCLI.{Output}
  import UnCLI.Core

  def pull(logged_in \\ logged_in?())

  def pull(true) do
    Output.put("Pulling new entries...")

    response = make_call(UnLibD.pull_now())
    print_response(response)
  end

  def pull(false) do
    Output.error!("Not authenticated.")
  end

  defp print_response(response) do
    for data <- response do
      if data.error do
        Output.error(data.error)
      else
        Output.put("Pulled #{length(data.entries)} entries from #{data.source.url}")
      end
    end
  end

  def prune do
    Output.put("Pruning entries...")
    make_call(UnLib.Entries.prune(user()))

    Output.put("Deleted all read entries.")
  end

  def prune_all do
    Output.put("Pruning entries...")
    make_call(UnLib.Entries.prune_all(user()))

    Output.put("Deleted all downloaded entries.")
  end
end
