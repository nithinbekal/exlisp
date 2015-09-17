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

  test "tokenizing expressions with extra spaces" do
    assert T.transform("(    )") == ["(", ")"]
    assert T.transform("( +  24 42  )") == ["(", "+", "24", "42", ")"]
  end

  test "tokenizing words" do
    assert T.transform("(define pi 3.14)") == ["(", "define", "pi", "3.14", ")"]
    assert T.transform("(define golden-ratio 1.59)") ==
      ["(", "define", "golden-ratio", "1.59", ")"]
  end

  test "complex expressions" do
    assert T.transform(" (define square (lambda (x) (* x x))) ")
      == ["(", "define", "square", "(", "lambda", "(", "x", ")",
              "(", "*", "x", "x", ")", ")", ")"]
  end

  test "expressions ending with newline" do
    assert T.transform("(+ 1 2)\n") == ["(", "+", "1", "2", ")"]
  end
end

