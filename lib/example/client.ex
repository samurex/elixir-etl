defmodule ElixirEtl.Example.Client do
  @behaviour ElixirEtl.Example.ExampleClient

  @impl true
  def get_dummy(text, count) do
    Stream.unfold(1, fn n -> {%{id: n, name: "#{text}"}, n + 1} end)
    |> Stream.take(count)
  end
end
