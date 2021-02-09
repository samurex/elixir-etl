defmodule ElixirEtl.Example.Pipeline do
  use ElixirEtl.Builder

  source ElixirEtl.Example.Source, text: "example pipeline", count: 100_000
  transformation ElixirEtl.Shared.Transformations.AddTimestamp, field_name: "created_at"
  transformation ElixirEtl.Shared.Transformations.EncodeJson
  transformation ElixirEtl.Shared.Transformations.SetExtension
  transformation ElixirEtl.Shared.Transformations.SetFilename
  transformation ElixirEtl.Shared.Transformations.SetPath
  destination ElixirEtl.Shared.Destinations.File

  post_action ElixirEtl.Shared.Actions.StartWorkflow
end
