defmodule Exlisp.TokenizerTest do
  use ExUnit.Case

  alias Exlisp.Tokenizer, as: T

  test "tokenizes simple numeric expressions" do
    assert T.transform("()") === ["(", ")"]
    assert T.transform("(1)") === ["(", "1", ")"]
    assert T.transform("(1 2)") === ["(", "1", "2", ")"]
    assert T.transform("(+ 1 2)") === ["(","+", "1", "2", ")"]
  end
end

