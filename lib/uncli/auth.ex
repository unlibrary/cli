defmodule UnCLI.Auth do
  @moduledoc false

  alias UnCLI.{Output}
  import UnCLI.Core

  def login do
    Output.title("Login")
    username = String.trim(IO.gets("Username: "))
    password = String.trim(IO.gets("Password: "))

    make_call(UnLibD.Auth.login(username, password))
    |> handle_login()
  end

  defp handle_login(:ok) do
    Output.put("Logged in successfully.")
  end

  defp handle_login(:invalid_password) do
    Output.error!("Password incorrect.")
  end

  defp handle_login(:no_user_found) do
    Output.error!("Account doesn't exist.")
  end

  def logout do
    make_call(UnLibD.Auth.logout())
    Output.put("Logged out successfully.")
  end
end
