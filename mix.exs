defmodule Emanatio.Mixfile do
  use Mix.Project

  def project do
    [ app: :emanatio,
      version: "0.0.1",
      elixir: "~> 0.12.4",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [mod: { Emanatio, [] }]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
     { :exactor, github: "sasa1977/exactor" },
     { :datastructures, github: "meh/elixir-datastructures" }
    ]
  end
end
