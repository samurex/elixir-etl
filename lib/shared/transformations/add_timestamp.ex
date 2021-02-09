defmodule ElixirEtl.Shared.Transformations.AddTimestamp do
  @behaviour ElixirEtl.Transformation

  @impl true
  def call(etl, options \\ []) do
    field_name = Keyword.get(options, :field_name)
    clock = Application.fetch_env!(:elixir_etl, :clock)

    timestamp = clock.utc_now() |> DateTime.to_iso8601()

    stream = Stream.map(etl.content, fn row -> Map.put(row, field_name, timestamp) end)

    %{etl | content: stream}
  end
end
