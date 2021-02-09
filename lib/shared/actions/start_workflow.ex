defmodule ElixirEtl.Shared.Actions.StartWorkflow do
  @behaviour ElixirEtl.Action

  @impl ElixirEtl.Action
  def call(etl = %ElixirEtl.Etl{storage_path: storage_path}, _options \\ []) do
    IO.puts("Starting workflow for #{storage_path}")
    etl
  end
end
