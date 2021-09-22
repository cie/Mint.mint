suite "Mint parsers" {
  test "eof ok" {
    with Test.Context {
      of(Mint.Grammar.eof("" |> Mint.tokens)) |> assertEqual(
        Result::Ok({void, []})
      )
    }
  }
  test "eof fail" {
    with Test.Context {
      of(Mint.Grammar.eof("module" |> Mint.tokens)) |> assertEqual(
        Result::Err({"`module`", []})
      )
    }
  }
  test "keyword" {
    with Test.Context {
      of("" |> Mint.tokens |> Mint.Grammar.keyword("module")) |> assertEqual(
        Result::Ok({void, []})
      )
    }
  }
}