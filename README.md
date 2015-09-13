# Exlisp

Exlisp is a simple lisp interpreter written in Elixir. So far, I have only
completed writing the tokenizer, which works like this:

```elixir
Exlisp.Tokenizer.transform("(+ 1 2)")
# => ["(", "+", "1", "2", ")"]
```

The next step is to write a parser which should ideally use the tokenizer to
generate something like this:

```elixir
Exlisp.Parser.transform("(+ 1 2)")
# => {:+, 1, 2}
```
