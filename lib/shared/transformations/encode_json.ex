defmodule ElixirEtl.Shared.Transformations.EncodeJson do
  @behaviour ElixirEtl.Transformation

  alias ElixirEtl.Etl

  @impl true
  def call(etl, _options \\ []) do
    %Etl{content: content} = etl

    stream =
      content
      |> Stream.map(fn map -> Jason.encode!(map) end)

    %{etl | content: stream, format: :json}
  end
end
