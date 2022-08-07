defmodule UnCLITest do
  use ExUnit.Case
  doctest UnCLI

  test "greets the world" do
    assert UnCLI.hello() == :world
  end
end
