defmodule ElixirEtl.Source do
  @callback call(args :: keyword(), opts :: keyword()) :: ElixirEtl.Etl.t
end
