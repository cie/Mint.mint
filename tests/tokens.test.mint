suite "Mint tokens" {
  test "empty string" {
    with Test.Context {
      of(Mint.tokens("")) |> assertEqual([])
    }
  }
  test "invalid" {
    with Test.Context {
      of(Mint.tokens("í")) |> assertEqual([
        Mint.Token::Invalid("í", "This character is not allowed")
      ])
    }
  }
  test "whitespace" {
    with Test.Context {
      of(Mint.tokens("    \n ")) |> assertEqual([])
    }
  }
  test "module" {
    with Test.Context {
      of(Mint.tokens("module  Mod {}")) |> assertEqual([
        Mint.Token::Keyword("module"),
        Mint.Token::Name("Mod", {var = false, constant = false, mod = true}),
        Mint.Token::Op("{"),
        Mint.Token::Op("}"),
      ])
    }
  }
  test "fun" {
    with Test.Context {
      of(Mint.tokens("fun  x() ")) |> assertEqual([
        Mint.Token::Keyword("fun"), 
        Mint.Token::Name("x", {var = true, constant = false, mod = false}),
        Mint.Token::Op("("),
        Mint.Token::Op(")"),
      ])
    }
  }
}
