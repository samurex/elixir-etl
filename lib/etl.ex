defmodule ElixirEtl.Etl do
  defstruct [
    :source,
    :type,
    :content,
    :filename,
    :path,
    :extension,
    :format,
    :storage,
    :storage_path,
    :params,
    :execution_time,
  ]

  @type option(type) :: type | nil
  @type t :: %__MODULE__{
          source: atom(),
          type: atom(),
          content: Enumerable.t(),
          filename: option(String.t()),
          path: option(String.t()),
          extension: option(String.t()),
          format: option(atom()),
          storage: option(atom()),
          storage_path: option(String.t()),
          params: option(keyword()),
          execution_time: option(float())
        }
end
