defmodule UnCLI.Entries do
  @moduledoc false

  alias UnCLI.{Output, Input}
  import UnCLI.Core

  require EEx

  def list(logged_in \\ logged_in?())

  def list(true) do
    entries = make_call(UnLib.Entries.list(user()))
    render_entry_list("unread", entries)
  end

  def list(false) do
    Output.error!("Not authenticated.")
  end

  def list_all(logged_in \\ logged_in?())

  def list_all(true) do
    entries = make_call(UnLib.Entries.list_all(user()))
    render_entry_list("downloaded", entries)
  end

  def list_all(false) do
    Output.error!("Not authenticated.")
  end

  defp render_entry_list(kind, entries) do
    Output.title("#{String.capitalize(kind)} posts")

    if entries == [] do
      "There are no #{kind} posts."
      |> Output.supplement()
      |> Output.italic()
      |> Output.put()
    end

    Enum.each(entries, &render_entry_item/1)

    Output.empty()
    Output.put("Showing #{length(entries)} posts.")
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
        entry
        |> mark_as_read()
        |> render_entry()

      {:error, error} ->
        Output.error!(error)
    end
  end

  defp mark_as_read(entry) do
    case make_call(UnLib.Entries.read(entry)) do
      {:ok, entry} -> entry
      {:error, changeset} -> Output.error!(changeset)
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
end
