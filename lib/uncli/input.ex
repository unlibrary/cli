defmodule UnCLI.Input do
  @moduledoc false

  def get do
    get("")
  end

  def get(label) do
    IO.gets(label)
    |> String.trim()
  end

  def sanitize_html(html) do
    html
    |> strip_newlines()
    |> HtmlSanitizeEx.basic_html()
  end

  defp strip_newlines(text) do
    text
    |> String.replace("\r", "")
    |> String.replace("\n", "")
  end
end
