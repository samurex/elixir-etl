defmodule ElixirEtl.Transformation do
  @callback call(ElixirEtl.Etl.t(), opts :: keyword()) :: ElixirEtl.Etl.t()
end
