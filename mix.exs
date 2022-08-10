defmodule UnCLI.MixProject do
  use Mix.Project

  def project do
    [
      name: "Unlibrary CLI",
      source_url: "https://github.com/unlibrary/cli",
      app: :uncli,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript(),
    ]
  end

  def application do
    [
      included_applications: [:unlib],
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:unlib, path: "../reader"},
    ]
  end

  def escript do
    [
      main_module: UnCLI
    ]
  end
end
