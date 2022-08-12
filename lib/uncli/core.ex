defmodule UnCLI.Core do
  @moduledoc false

  @spec make_call(fun()) :: term()
  defmacro make_call(fun) do
    {{:__aliases__, _, modules}, fun, args} = Macro.decompose_call(fun)
    module = Module.concat(modules)
    server = :readerd@delta

    quote do
      :erpc.call(unquote(server), unquote(module), unquote(fun), unquote(args))
    end
  end

  def logged_in? do
    make_call(UnLibD.Auth.logged_in?())
  end

  def user do
    make_call(UnLibD.Auth.current_user())
  end
end
