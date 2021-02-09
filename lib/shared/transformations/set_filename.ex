defmodule ElixirEtl.Shared.Transformations.SetFilename do
  @behaviour ElixirEtl.Transformation

  alias ElixirEtl.Etl

  @impl true
  def call(etl, _options \\ []) do
    clock = Application.fetch_env!(:elixir_etl, :clock)
    str_date = clock.utc_now() |> Date.to_iso8601(:basic)
    filename = "#{str_date}"

    %Etl{etl | filename: filename}
  end
end
