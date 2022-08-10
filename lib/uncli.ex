defmodule UnCLI do
  @moduledoc """
  Public API for `UnCLI`.
  """

  alias UnCLI.Client

  defdelegate main(args), to: Client, as: :call
end
