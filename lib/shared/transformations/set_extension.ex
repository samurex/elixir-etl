defmodule ElixirEtl.Shared.Transformations.SetExtension do
  @behaviour ElixirEtl.Transformation

  alias ElixirEtl.Etl

  @impl true
  def call(etl, _options \\ []) do
    %Etl{format: format} = etl

    extension =
      case format do
        :json -> "json"
        :serde -> "json"
        :csv -> "csv"
      end

    %{etl | extension: extension}
  end
end
