defmodule UnCLI.Core do
  @moduledoc false

  def logged_in? do
    true
  end

  def user do
    UnLib.Repo.one(UnLib.Account)
    |> UnLib.Repo.preload(:sources)
  end
end
