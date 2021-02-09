defmodule ElixirEtl.Clock do
  @callback utc_now() :: DateTime.t()
end
