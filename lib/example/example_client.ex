defmodule ElixirEtl.Example.ExampleClient do
  @callback get_dummy(text :: String.t(), count :: integer()) :: Enumerable.t()
end
