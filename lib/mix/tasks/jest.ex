defmodule Mix.Tasks.Jest do
  @moduledoc "Run JavaScript tests"
  use Mix.Task

  def run(_) do
    System.cmd("npm", ["test"], cd: "assets")
  end
end
