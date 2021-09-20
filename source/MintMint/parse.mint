record Mint.Loc {
  line : Number,
  column : Number,
  offset : Number
}

enum Mint.ParseResult(t) {
  Ok(t, Array(Mint.Token))
  Err(String)
 /* , Mint.Loc, Mint.Loc */
}

enum Mint.Grammar(t) {
  T(Mint.Token, t)
  /*
  Match(Function(Mint.Token, Mint.ParseResult(t)))
  Some(Mint.Grammar(a), Function(Array(a), t))
  Seq2(Mint.Grammar(a), Mint.Grammar(b), Function(a, b, t))
  Seq3(Mint.Grammar(a), Mint.Grammar(b), Mint.Grammar(c), Function(a, b, c, t))
  */
  Either(Array(Mint.Grammar(t)))
}

module Mint.Grammar {
  fun keyword (name : String, value : t) {
    (tokens : Array(Mint.Token)) {
      case (tokens) {
        [first, ...rest] => case(first) {
          Mint.Token::Keyword(name) => Mint.ParseResult::Ok(value, rest)
          => Mint.ParseResult::Err("expected " + name)
        }
        => Mint.ParseResult::Err("expected " + name)
      }
    }
  }
  const FILE = keyword("module")
}

module Mint.ParseResult {
  fun toString(r : Mint.ParseResult(Mint.File)) {
    case(r) {
      Mint.ParseResult::Ok(file, rest) => Mint.AST.fileToString(file)
      Mint.ParseResult::Err(msg) => msg
    }
  }
}