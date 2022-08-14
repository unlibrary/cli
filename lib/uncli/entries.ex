defmodule UnCLI.Entries do
  @moduledoc false

  alias UnCLI.{Output, Input}
  import UnCLI.Core

  require EEx

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

    url = Output.supplement("(#{entry.id})")
    Output.item("#{name} #{url}")

    entry.url
    |> Output.italic()
    |> Output.put()

    Output.empty()
  end

  def read(id) do
    case make_call(UnLib.Entries.get(id)) do
      {:ok, entry} ->
        render_entry(entry)

      {:error, error} ->
        Output.empty()
        Output.error!(error)
    end
  end

  defp render_entry(entry) do
    Output.put("Opening #{entry.title} in the browser...")

    path = "/tmp/unlib_#{filenamify(entry.source.name)}_#{entry.id}.html"

    html =
      entry.body
      |> Input.sanitize_html()
      |> generate_page(entry.title, entry.source.name)

    File.write!(path, html, [:write])
    System.cmd("xdg-open", [path])
  end

  defp filenamify(name) do
    name
    |> String.downcase()
    |> String.replace(" ", "_")
    |> String.replace("/", "_")
  end

  EEx.function_from_file(:def, :generate_page, "lib/uncli/entry.eex", [:body, :title, :author])

  def prune() do
    make_call(UnLib.Entries.prune())
    Output.empty()
    Output.put("Pruning entries.")
  end
end
