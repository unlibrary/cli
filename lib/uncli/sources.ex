defmodule UnCLI.Sources do
  @moduledoc false

  alias UnCLI.{Output, Input}
  import UnCLI.Core

  def add(logged_in \\ logged_in?())

  def add(true) do
    Output.title("Create account")

    title = Input.get("Title: ")
    url = Input.get("Feed URL: ")

    type =
      Input.get("Type (rss, atom or mf2): ")
      |> to_atom()

    user = user()
    {:ok, source} = make_call(UnLib.Sources.new(url, type, title))

    make_call(UnLib.Sources.add(source, user))
    |> handle_creation()
  end

  def add(false) do
    Output.error!("Not authenticated.")
  end

  defp to_atom(string) do
    if string in ["rss", "atom", "mf2"] do
      String.to_atom(string)
    else
      Output.empty()
      Output.error!("Invalid type given.")
    end
  end

  defp handle_creation({:ok, account}) do
    Output.empty()
    make_call(UnLibD.Auth.refresh(account))
    Output.put("The source was added successfully.")
  end

  defp handle_creation({:error, error}) do
    Output.empty()
    Output.error!(error)
  end

  def list(logged_in \\ logged_in?())

  def list(true) do
    Output.title("Sources")

    sources = user().sources

    if sources == [] do
      "This account doesn't contain any sources."
      |> Output.supplement()
      |> Output.italic()
      |> Output.put()
    end

    Enum.each(sources, &render_source/1)

    Output.empty()
    Output.put("Showing #{length(sources)} sources.")
  end

  def list(false) do
    Output.error!("Not authenticated.")
  end

  defp render_source(source) do
    name =
      case source.name do
        nil -> Output.italic("No name")
        name -> name
      end

    url = Output.supplement("(#{source.url})")
    Output.item("#{name} #{url}")
  end

  def remove(url, logged_in \\ logged_in?())

  def remove(url, true) do
    case make_call(UnLib.Sources.get_by_url(url)) do
      {:ok, source} ->
        user = user()

        make_call(UnLib.Sources.remove(source, user))
        |> handle_removal()

      {:error, changeset} ->
        Output.error!(changeset)
    end
  end

  def remove(_url, false) do
    Output.error!("Not authenticated.")
  end

  defp handle_removal({:error, error}) do
    Output.empty()
    Output.error!(error)
  end

  defp handle_removal({:ok, account}) do
    make_call(UnLibD.Auth.refresh(account))
    Output.put("The source was removed successfully.")
  end
end
