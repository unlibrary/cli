defmodule UnCLI.Accounts do
  @moduledoc false

  alias UnCLI.{Output, Input}
  import UnCLI.Core

  def create do
    Output.title("Create account")
    username = Input.get("Username: ")
    password = Input.get("Password: ")

    make_call(UnLib.Accounts.create(username, password))
    |> handle_creation()
  end

  defp handle_creation({:error, changeset}) do
    Output.empty()
    Output.error(changeset)
  end

  defp handle_creation({:ok, _account}) do
    Output.empty()
    Output.put("Your account was created successfully.")
  end
end
