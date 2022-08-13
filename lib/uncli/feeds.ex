defmodule UnCLI.Feeds do
  @moduledoc false

  alias UnCLI.{Output}
  import UnCLI.Core

  def pull(logged_in \\ logged_in?())

  def pull(true) do
    make_call(UnLibD.pull_now())
    Output.empty()
    Output.put("Pulling new entries.")
  end

  def pull(false) do
    Output.empty()
    Output.error!("Not authenticated.")
  end
end
