defmodule ElixirEtl.Shared.Destinations.File do
  @behaviour ElixirEtl.Destination

  alias ElixirEtl.Etl

  @impl true
  def call(etl, _opts \\ []) do
    file = Application.fetch_env!(:elixir_etl, :file)
    %Etl{content: content, path: path, filename: filename, extension: extension} = etl

    # NOTE: side effect here
    :ok = file.mkdir_p!("/tmp/#{path}")

    storage_path = "/tmp/#{path}/#{filename}.#{extension}"

    stream = Stream.into(content, file.stream!(storage_path))

    %{etl | content: stream, storage: :file, storage_path: storage_path}
  end
end
