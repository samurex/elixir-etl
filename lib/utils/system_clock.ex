defmodule ElixirEtl.SystemClock do
  @behaviour ElixirEtl.Clock

  @impl true
  def utc_now() do
    DateTime.utc_now()
  end
end
