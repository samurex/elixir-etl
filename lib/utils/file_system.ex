defmodule ElixirEtl.Utils.FileSystem do
  @behaviour ElixirEtl.Utils.File

  @impl true
  def mkdir_p!(path) do
    File.mkdir_p!(path)
  end

  @impl true
  def stream!(path) do
    File.stream!(path)
  end
end
