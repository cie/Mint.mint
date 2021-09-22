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
        Mint.Token::CapitalName("Mod"),
        Mint.Token::Op("{"),
        Mint.Token::Op("}"),
      ])
    }
  }
  test "fun" {
    with Test.Context {
      of(Mint.tokens("fun  x() ")) |> assertEqual([
        Mint.Token::Keyword("fun"), 
        Mint.Token::SmallName("x"),
        Mint.Token::Op("("),
        Mint.Token::Op(")"),
      ])
    }
  }
}
