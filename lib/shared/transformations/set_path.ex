defmodule ElixirEtl.Shared.Transformations.SetPath do
  @behaviour ElixirEtl.Transformation

  alias ElixirEtl.Etl

  @impl true
  def call(etl, _options \\ []) do
    %Etl{source: source, type: type} = etl

    path = "#{to_string(source)}/#{to_string(type)}"

    %{etl | path: path}
  end
end
