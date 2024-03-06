defmodule GoogleAiExTest do
  use ExUnit.Case
  doctest GoogleAiEx

  test "greets the world" do
    assert GoogleAiEx.hello() == :world
  end
end
