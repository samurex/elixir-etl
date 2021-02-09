defmodule ElixirEtl.Example.Source do
  @behaviour ElixirEtl.Source

  alias ElixirEtl.Etl

  @impl true
  def call(args, opts) do
    options = Keyword.merge(opts, args)
    count = Keyword.get(options, :count)
    text = Keyword.get(options, :text)
    example_clinet = Application.fetch_env!(:elixir_etl, :example_client)

    stream = example_clinet.get_dummy(text, count)

    %Etl{
      source: :dummy,
      type: :dummy_type,
      content: stream,
      params: opts
    }
  end
end
