defmodule ElixirEtl.Utils.File do
  @callback mkdir_p!(String.t()) :: :ok
  @callback stream!(String.t()) :: File.Stream.t()
end
