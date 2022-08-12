defmodule UnCLI.Output.Help do
  @moduledoc false

  alias UnCLI.{Output}
  import IO.ANSI

  @version "0.1.0"

  def header(name, description) do
    Output.put(green() <> name <> reset() <> " v#{@version}")
    Output.put(description)
    Output.empty()
  end

  def items(title, items) when is_binary(hd(items)) do
    items =
      Enum.map(items, fn item ->
        {item, ""}
      end)

    items(title, items)
  end

  def items(title, items) do
    title(title)

    Enum.each(items, fn {item, description} ->
      item = green() <> item <> reset()
      Output.put("    #{item}")

      if description != "" do
        Output.put("        #{description}")
        Output.empty()
      end
    end)

    Output.empty()
  end

  def title(title) do
    "#{title}:"
    |> String.upcase()
    |> yellow()
    |> Output.put()
  end

  defp yellow(text) do
    yellow() <> text <> reset()
  end
end
