defmodule Exlisp.ParserTest do
  use ExUnit.Case

  alias Exlisp.Parser, as: P

  test "parsing simple expressions" do
    assert P.transform("(+ 1 2)") == [ [:+, 1, 2] ]
  end

  test "parsing nested expressions" do
    assert P.transform("(+ 1 (* 2 3))") == [ [:+, 1, [:*, 2, 3]] ]
    assert P.transform("(+ (/ 12 42) (* 2 3 4))") == [ [:+,
        [:/, 12, 42],
        [:*, 2, 3, 4]
      ] ]
  end

  test "throws exception on missing parentheses" do
    assert catch_throw(P.transform("(+ 1 (* 3 8)")) == :missing_rparen
  end
end
