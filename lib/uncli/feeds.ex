defmodule UnCLI.Feeds do
  @moduledoc false

  alias UnCLI.{Output}
  import UnCLI.Core

  def pull(logged_in \\ logged_in?())

  def pull(true) do
    Output.put("Pulling new entries...")

    response = make_call(UnLibD.pull_now())
    print_errors(response)
  end

  def pull(false) do
    Output.error!("Not authenticated.")
  end

  defp print_errors(response) do
    for data <- response do
      if data.error do
        Output.error(data.error)
      else
        Output.put("Pulled #{data.source.name}")
      end
    end
  end
end
