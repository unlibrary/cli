defmodule UnCLI.Input do
  @moduledoc false

  def get do
    get("")
  end

  def get(label) do
    IO.gets(label)
    |> String.trim()
  end
end
