alias ElixirEtl.Etl

defmodule ElixirEtl.Destination do
  @callback call(Etl.t, options :: keyword()) :: Etl.t
end
