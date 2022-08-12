defmodule UnCLI.Output do
  @moduledoc false

  import IO.ANSI

  def title(text) do
    IO.puts(magenta() <> "# " <> bright() <> "#{text}\n" <> reset())
  end

  def subtitle(text) do
    IO.puts(magenta() <> "## " <> bright() <> "#{text}" <> reset())
  end

  def author(name) do
    IO.puts(blue() <> "@" <> name <> reset())
  end

  def seperator() do
    IO.puts(blue() <> "----------------------------\n" <> reset())
  end

  def item(id, text) do
    IO.puts("(#{id}) #{text}")
  end

  def item(text) do
    IO.puts("* #{text}")
  end

  def put(text) do
    IO.puts(text)
  end

  def put_html(text) do
    text
    |> strip_newlines()
    |> HtmlSanitizeEx.strip_tags()
    |> put()
  end

  defp strip_newlines(text) do
    text
    |> String.replace("\r", "")
    |> String.replace("\n", "")
  end

  def empty() do
    IO.puts("")
  end

  def error(%Ecto.Changeset{} = changeset) do
    changeset
    |> format_error()
    |> error()
  end

  def error(text) do
    IO.puts(bright() <> red() <> "Error: " <> reset() <> red() <> text <> reset())
    exit({:shutdown, 1})
  end

  def format_error(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        value =
          case value do
            [value] -> value
            value -> value
          end

        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
    |> Enum.reduce("", fn {k, v}, _acc ->
      joined_errors = Enum.join(v, "; ")
      String.capitalize("#{k} #{joined_errors}")
    end)
  end

  def italic(text) do
    italic() <> text <> reset()
  end

  def underline(text) do
    underline() <> text <> no_underline()
  end

  def supplement(text) do
    italic(faint() <> text <> reset())
  end

  def clear_screen() do
    IEx.Helpers.clear()
  end
end
