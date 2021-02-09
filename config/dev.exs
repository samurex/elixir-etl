import Config

config :elixir_etl,
  clock: ElixirEtl.SystemClock,
  example_client: ElixirEtl.Example.Client,
  file: ElixirEtl.Utils.FileSystem
