defmodule PipelineTest do
  use ExUnit.Case

  alias ElixirEtl.Example.Pipeline

  alias ElixirEtl.ClockMock
  alias ElixirEtl.Example.ClientMock
  alias ElixirEtl.Utils.FileMock
  alias ElixirEtl.Etl

  import Mox

  setup :verify_on_exit!

  test "run/1 creates correct etl object" do
    ClientMock
    |> expect(:get_dummy, fn "example pipeline", 100_000 ->
      [
        %{"id" => 1, "name" => "dummy1"},
        %{"id" => 2, "name" => "dummy2"}
      ]
    end)

    ClockMock
    |> expect(:utc_now, 2, fn ->
      DateTime.from_naive!(~N[1990-01-01 00:00:00.000], "Etc/UTC")
    end)

    FileMock
    |> expect(:mkdir_p!, fn "/tmp/dummy/dummy_type" -> :ok end)
    |> expect(:stream!, fn "/tmp/dummy/dummy_type/19900101.json" ->
      %File.Stream{}
    end)

    %Etl{content: content} = Pipeline.run([])

    assert Enum.to_list(content) == [
      "{\"created_at\":\"1990-01-01T00:00:00.000Z\",\"id\":1,\"name\":\"dummy1\"}",
      "{\"created_at\":\"1990-01-01T00:00:00.000Z\",\"id\":2,\"name\":\"dummy2\"}"
    ]
  end
end
