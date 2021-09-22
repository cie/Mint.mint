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
        Result::Err({"end of file", [Mint.Token::Keyword("module")]})
      )
    }
  }
  test "keyword ok" {
    with Test.Context {
      of(Mint.Grammar.keyword("module")("module" |> Mint.tokens)) |> assertEqual(
        Result::Ok({void, []})
      )
    }
  }
  test "keyword fail" {
    with Test.Context {
      of(Mint.Grammar.keyword("module")("true" |> Mint.tokens)) |> assertEqual(
        Result::Err({"`module`", [Mint.Token::Keyword("true")]})
      )
    }
  }
}