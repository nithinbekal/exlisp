defmodule Exlisp.Tokenizer do
  def transform(src) do
    src
    |> String.split("")
    |> _tokenize([], [])
  end

  defp _tokenize([ch | rest], [], tokens)
  when ch in ["", " ", "\n"] do
    _tokenize(rest, [], tokens)
  end

  defp _tokenize([ch | rest], acc, tokens)
  when ch in ["", " "] do
    _tokenize(rest, [], [_join_accumulated(acc) | tokens])
  end

  defp _tokenize(["(" | rest], [], tokens) do
    _tokenize(rest, [], ["(" | tokens])
  end

  defp _tokenize([")" | rest], [], tokens) do
    _tokenize(rest, [], [")" | tokens])
  end

  defp _tokenize([")" | rest], acc, tokens) do
    _tokenize(rest, [], [")" | [_join_accumulated(acc) | tokens]])
  end

  defp _tokenize([ch | rest], [], tokens) do
    _tokenize(rest, [ch], tokens)
  end

  defp _tokenize([ch | rest], acc, tokens) do
    _tokenize(rest, [ch | acc], tokens)
  end

  defp _tokenize([], _acc, tokens) do
    Enum.reverse(tokens)
  end

  defp _join_accumulated(list) do
    list
    |> Enum.reverse
    |> Enum.join
  end
end

