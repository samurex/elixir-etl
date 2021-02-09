alias ElixirEtl.Etl

defmodule ElixirEtl.Action do
  @callback call(Etl.t, opts :: keyword()) :: Etl.t
end
