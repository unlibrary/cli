defmodule UnCLI.Entries do
  @moduledoc false

  alias UnCLI.{Output}
  import UnCLI.Core

  def list(logged_in \\ logged_in?())

  def list(true) do
    Output.title("Recent posts")

    user = user()
    entries = make_call(UnLib.Entries.list(user))
    Enum.each(entries, &render_entry/1)

    Output.empty()
    Output.put("Showing #{length(entries)} posts.")
  end

  def list(false) do
    Output.empty()
    Output.error!("Not authenticated.")
  end

  defp render_entry(entry) do
    name =
      case entry.title do
        nil -> Output.italic("No title")
        name -> name
      end

    url = Output.supplement("(#{entry.url})")
    Output.item("#{name} #{url}")
  end

  def read(_url) do
    Output.error!(
      "Sorry, I was stupid and forgot to implement the one fucking thing a RSS reader is meant for. Reading the fucking posts >:("
    )
  end
end
