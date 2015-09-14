defmodule Exlisp.Parser do
  def transform(source) do
    source
    |> Exlisp.Tokenizer.transform()
    |> _convert_types()
    |> _parse_list()
  end

  defp _convert_types([head | tail]) do
    new_head = cond do
      operator?(head) -> String.to_atom(head)
      numeric?(head)  -> String.to_integer(head)
      true            -> head
    end

    [new_head | _convert_types(tail)]
  end

  defp _convert_types([]), do: []

  defp operator?(s), do: Enum.member?(["+", "-", "*", "/"], s)
  defp numeric?(string), do: Regex.match?(~r/[0-9]+/, string)

  defp _parse_list(list) do
    _parse(list, 0, [])
  end

  defp _parse([], 0, acc) do
    Enum.reverse(acc)
  end

  defp _parse(["(" | rest], level, acc) do
    {remaining, parsed} = _parse_inner(rest, [])
    _parse(remaining, level, [parsed | acc])
  end

  defp _parse([")" | rest], level, acc) do
    _parse(rest, level-1, acc)
  end

  defp _parse_inner([], _) do
    throw :missing_rparen
  end

  defp _parse_inner(["(" | rest], acc) do
    { remaining, tree } = _parse_inner(rest, [])
    _parse_inner(remaining, [tree | acc])
  end

  defp _parse_inner([")" | rest], acc) do
    { rest, Enum.reverse(acc) }
  end

  defp _parse_inner([first | rest], acc) do
    _parse_inner(rest, [first | acc])
  end
end
