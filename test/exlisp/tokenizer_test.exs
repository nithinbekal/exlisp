defmodule Exlisp.TokenizerTest do
  use ExUnit.Case

  alias Exlisp.Tokenizer, as: T

  test "tokenizing simple numeric expressions" do
    assert T.transform("()") === ["(", ")"]
    assert T.transform("(1)") === ["(", "1", ")"]
    assert T.transform("(1 2)") === ["(", "1", "2", ")"]
    assert T.transform("(+ 1 2)") === ["(","+", "1", "2", ")"]
  end

  test "tokenizing multiple digit numbers" do
    assert T.transform("(1337)") == ["(", "1337", ")"]
    assert T.transform("(+ 24 42)") == ["(", "+", "24", "42", ")"]
  end
end

