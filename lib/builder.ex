defmodule ElixirEtl.Builder do
  defmacro __using__(_opts \\ []) do
    quote do
      Module.register_attribute(__MODULE__, :source_ast, [])
      Module.register_attribute(__MODULE__, :destination_ast, [])
      Module.register_attribute(__MODULE__, :transformations_ast, accumulate: true)
      Module.register_attribute(__MODULE__, :post_action_ast, [])

      import ElixirEtl.Builder
      @before_compile ElixirEtl.Builder

      alias ElixirEtl.Etl
    end
  end

  defmacro source(name, opts \\ []) do
    quote do
      @source_ast {unquote(Macro.escape(name)), unquote(Macro.escape(opts))}
    end
  end

  defmacro destination(name, opts \\ []) do
    quote do
      @destination_ast {unquote(Macro.escape(name)), unquote(Macro.escape(opts))}
    end
  end

  defmacro transformation(name, opts \\ []) do
    quote do
      @transformations_ast {unquote(Macro.escape(name)), unquote(Macro.escape(opts))}
    end
  end

  defmacro post_action(name, opts \\ []) do
    quote do
      @post_action_ast {unquote(Macro.escape(name)), unquote(Macro.escape(opts))}
    end
  end

  defmacro __before_compile__(env) do
    source_ast =
      env.module
      |> Module.get_attribute(:source_ast)
      |> compile()

    destination_ast =
      env.module
      |> Module.get_attribute(:destination_ast)
      |> compile()

    transformations_ast =
      env.module
      |> Module.get_attribute(:transformations_ast)
      |> Enum.reverse()
      |> compile()

    post_action_ast =
      env.module
      |> Module.get_attribute(:post_action_ast)
      |> compile()

    quote do
      @spec run(keyword(), keyword()) :: ElixirEtl.Etl.t
      def run(args, opts \\ []) do
        {source_mod, source_opts} = unquote(source_ast)
        {destination_mod, destination_opts} = unquote(destination_ast)
        {post_action_mod, post_action_opts} = unquote(post_action_ast)
        transformations = unquote(transformations_ast)

        {time_in_microseconds, etl} = :timer.tc(fn ->
          Enum.reduce(transformations, source_mod.call(args, source_opts),
            fn {t_mod, t_opts}, acc -> t_mod.call(acc, t_opts)
          end)
          |> destination_mod.call(destination_opts)
          |> run_stream
          |> post_action_mod.call(post_action_opts)
        end)

        %{etl | execution_time: time_in_microseconds / 1_000_000}
      end

      defp run_stream(etl = %ElixirEtl.Etl{content: content}) do
        :ok = Stream.run(content)
        etl
      end
    end
  end

  defp compile(nil), do: nil
  defp compile(list) when is_list(list), do: Enum.map(list, &compile/1)

  defp compile({{:__aliases__, _, _} = ast_mod, ast_opts}) do
    quote do: {unquote(ast_mod), unquote(ast_opts)}
  end
end
