defmodule UnCLI.Auth do
  @moduledoc false

  alias UnCLI.{Output}
  import UnCLI.Core

  def login do
    if logged_in?() do
      Output.empty()
      Output.error("Already logged in.")
      Output.put("(maybe log out using `auth logout` first)")
    else
      Output.title("Login")
      username = String.trim(IO.gets("Username: "))
      password = String.trim(IO.gets("Password: "))

      make_call(UnLibD.Auth.login(username, password))
      |> handle_login()
    end
  end

  defp handle_login(:ok) do
    Output.empty()
    Output.put("Logged in successfully.")
  end

  defp handle_login(:invalid_password) do
    Output.empty()
    Output.error!("Password incorrect.")
  end

  defp handle_login(:no_user_found) do
    Output.empty()
    Output.error!("Account doesn't exist.")
  end

  def logout do
    Output.empty()

    if logged_in?() do
      make_call(UnLibD.Auth.logout())
      Output.put("Logged out successfully.")
    else
      Output.error!("Not authenticated.")
    end
  end
end
