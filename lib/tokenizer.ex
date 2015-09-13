defmodule Exlisp.Tokenizer do
  def transform(src) do
    src
    |> String.split("")
    |> _tokenize([])
  end

  defp _tokenize([ch | rest], tokens)
  when ch in ["", " "] do
    _tokenize(rest, tokens)
  end

  defp _tokenize(["(" | rest], tokens) do
    _tokenize(rest, ["(" | tokens])
  end

  defp _tokenize([")" | rest], tokens) do
    _tokenize(rest, [")" | tokens])
  end

  defp _tokenize([head | rest], tokens) do
    _tokenize(rest, [head | tokens])
  end

  defp _tokenize([], tokens) do
    Enum.reverse(tokens)
  end
end

