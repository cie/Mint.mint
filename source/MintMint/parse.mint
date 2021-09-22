record Mint.Loc {
  line : Number,
  column : Number,
  offset : Number
}

  /*
  T(Mint.Token, t)
  Match(Function(Mint.Token, Mint.ParseResult(t)))
  Some(Mint.Grammar(a), Function(Array(a), t))
  Seq2(Mint.Grammar(a), Mint.Grammar(b), Function(a, b, t))
  Seq3(Mint.Grammar(a), Mint.Grammar(b), Mint.Grammar(c), Function(a, b, c, t))
  Either(Array(Mint.Grammar(t)))
  */

module Mint.Grammar {
  /*fun keyword (name : String, tokens : Array(Mint.Token)) {
    takeOne("`#{name}`", tokens) |> andThen((t : token) {
      if (t == Mint.Token::Keyword(name)) {
        Result.ok({void, rest})
      }
      case (t) {
        Mint.Token::Keyword(x) => Result.ok({void, rest})
        => Result.error({"`#{name}`", tokens})
      }
    })
    case (tokens) {
      [a, ...rest] => case (a) { Mint.Token::Keyword(name) => Result.ok({void, rest})
      => Result.error({"`#{name}`", tokens}) } => Result.error({"`#{name}`", tokens})
    }
  }
  fun take (tokens : Array(Mint.Token))
  fun parse(g : Mint.Grammar(t), tokens : Array(Mint.Token)) {
    case (g) { Mint.Grammar::G(name, fn) => fn(tokens) }
  }*/

  fun t(token : Mint.Token, tokens : Array(Mint.Token)) {
    with Mint.Token {
      case (tokens) {
        [first, ...rest] =>
          if (first == token) {
            Result.ok({void, rest})
          } else {
            Result.error({toString(token), tokens})
          }
        [] => Result.error({toString(token), []})
      }
    }
  }

  fun keyword(s : String) {
    t(Mint.Token::Keyword(s))
  }

  fun eof(tokens : Array(Mint.Token)) {
    if (tokens |> Array.isEmpty) {
      Result.ok({void, []})
    } else {
      Result.error({"end of file", tokens})
    }
  }
  const FILE = eof
}

module Mint {
  fun parse(s : String) {
    s |> Mint.tokens |> Mint.Grammar:FILE
  }
}