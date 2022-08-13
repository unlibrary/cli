defmodule UnCLI.MixProject do
  use Mix.Project

  @mix_env Mix.env()

  def project do
    [
      name: "Unlibrary CLI",
      source_url: "https://github.com/unlibrary/cli",
      app: :uncli,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: @mix_env == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto, "~> 3.0"},
      {:html_sanitize_ex, "~> 1.4"}
    ]
  end

  def escript do
    [
      main_module: UnCLI,
      emu_args: "-sname uncli"
    ]
  end
end
