defmodule Exlisp do
  def main(_) do
    IO.puts "Starting Exlisp..."
    repl()
  end

  defp repl do
    case IO.gets(:stdio, "exlisp> ") do
      "q\n" -> Process.exit(self, :kill)
      code ->
        ast = Exlisp.Parser.transform(code)
        IO.puts inspect ast
    end
    repl()
  end
end
