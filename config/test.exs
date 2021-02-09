import Config

config :elixir_etl,
  clock: ElixirEtl.ClockMock,
  example_client: ElixirEtl.Example.ClientMock,
  file: ElixirEtl.Utils.FileMock
