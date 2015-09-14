# Exlisp

Exlisp is a simple lisp interpreter written in Elixir. So far, I have only
completed writing the tokenizer and parser, which works like this:

```elixir
Exlisp.Tokenizer.transform("(+ 1 2)")
# => ["(", "+", "1", "2", ")"]
```

The parser transforms the tokens into an AST like this:

```elixir
Exlisp.Parser.transform("(+ (/ 12 42) (* 2 3 4))")
[ [:+,
  [:/, 12, 42],
  [:*, 2, 3, 4]
] ]
```

# Credits

* The tokenizer and parser are based on @mrshankly's [Lisir](https://github.com/mrshankly/lisir) interpreter.
