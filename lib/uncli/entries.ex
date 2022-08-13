defmodule UnCLI.Entries do
  @moduledoc false

  alias UnCLI.{Output}
  import UnCLI.Core

  def list(logged_in \\ logged_in?())

  def list(true) do
    Output.title("Downloaded posts")

    user = user()
    entries = make_call(UnLib.Entries.list(user))

    if entries == [] do
      "There are no downloaded posts."
      |> Output.supplement()
      |> Output.italic()
      |> Output.put()
    end

    Enum.each(entries, &render_entry_item/1)

    Output.empty()
    Output.put("Showing #{length(entries)} posts.")
  end

  def list(false) do
    Output.empty()
    Output.error!("Not authenticated.")
  end

  defp render_entry_item(entry) do
    name =
      case entry.title do
        nil -> Output.italic("No title")
        name -> name
      end

    url = Output.supplement("(#{entry.url})")
    Output.item("#{name} #{url}")
  end

  def read(url) do
    case make_call(UnLib.Entries.get_by_url(url)) do
      {:ok, entry} ->
        render_entry(entry)

      {:error, error} ->
        Output.empty()
        Output.error!(error)
    end
  end

  defp render_entry(entry) do
    Output.title(entry.title)
    Output.author(entry.source.name)

    Output.put_html(entry.body)
  end

  def prune() do
    make_call(UnLib.Entries.prune())
    Output.empty()
    Output.put("Pruning entries.")
  end
end
