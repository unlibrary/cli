defmodule UnCLI.Core do
  @moduledoc false

  alias UnCLI.{Output}

  @spec make_call(fun()) :: term()
  defmacro make_call(fun) do
    {{:__aliases__, _, modules}, fun, args} = Macro.decompose_call(fun)
    module = Module.concat(modules)
    server = get_server()

    quote do
      if Node.connect(unquote(server)) do
        :erpc.call(unquote(server), unquote(module), unquote(fun), unquote(args))
      else
        Output.error!("reader daemon is not online")
      end
    end
  end

  defp get_server() do
    Application.fetch_env!(:uncli, :server)
  end

  def logged_in? do
    make_call(UnLibD.Auth.logged_in?())
  end

  def user do
    make_call(UnLibD.Auth.current_user())
  end
end
