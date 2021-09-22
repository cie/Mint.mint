enum Mint.Token {
  Keyword(String)
  SmallName(String)
  CapitalName(String)
  Invalid(String, String)
  Op(String)
}

module Mint.Token {
  fun toString(t: Mint.Token) {
    case (t) {
      Mint.Token::Keyword(s) => "`#{s}`"
      Mint.Token::SmallName(s) => "small-letter name"
      Mint.Token::CapitalName(s) => "capital-letter name"
      Mint.Token::Op(s) => "`#{s}`"
      Mint.Token::Invalid(s, msg) => "invalid token: " + s + " - " + msg
    }
  }
}

module Mint {
  const TOKENS = [
    {"(?:module|fun|const|and|or|true|false)\\b", (s : String) { Mint.Token::Keyword(s) }},
    {"(?:=>|==|!=|&&|\\|\\||\\|>|[(){}[\\].,:/*+\\-=])", (s : String) { Mint.Token::Op(s) }},
    {"[A-Z][a-zA-Z0-9_]*", (s : String) { Mint.Token::CapitalName(s) }},
    {"[a-z][a-zA-Z0-9_]*", (s : String) { Mint.Token::SmallName(s) }},
    {"\\S", (s : String) { Mint.Token::Invalid(s, "This character is not allowed") }}
  ]

  const TOKEN_REGEXP = with Regexp {
      createWithOptions(
        for (tok of TOKENS) {
          "(" + tok[0] + ")"
        }
        |> String.join("|"),
        { caseInsensitive = false, multiline = true, unicode = true, global = true, sticky = false }
      )
  }

  fun tokens(s : String) {
    with Regexp {
      for (m of TOKEN_REGEXP |> matches(s)) {
        try {
          x = m.submatches |> Array.indexOf(m.match)
          (TOKENS[x] or INTERNAL_ERROR)[1](m.match)
        }
      }
    }
  }
  const INTERNAL_ERROR = {"",(s: String){Mint.Token::Invalid("", "internal error")}}
}