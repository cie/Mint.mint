record Mint.NameType {
  var: Bool,
  constant: Bool,
  mod: Bool
}

enum Mint.Token {
  Keyword(String)
  Name(String, Mint.NameType)
  Invalid(String, String)
  Op(String)
}

module Mint.Token {
  fun toString(t: Mint.Token) {
    case (t) {
      Mint.Token::Keyword(s) => "`" + s + "`"
      Mint.Token::Name(s, t) => s
      Mint.Token::Op(s) => s
      Mint.Token::Invalid(s, msg) => "invalid token: " + s + " - " + msg
    }
  }
}

module Mint {
  const TOKENS = [
    {"\\b(?:module|fun|const|and|or)\\b", (s : String) { Mint.Token::Keyword(s) }},
    {"(?:[(){}[\\].,:/*+\\-=])", (s : String) { Mint.Token::Op(s) }},
    {"\\b[A-Z][A-Z_]+\\b", (s : String) { 
      Mint.Token::Name(s, {var = false, constant = true, mod = false}) }},
    {"\\b[A-Z][a-zA-Z]*\\b", (s : String) {
      Mint.Token::Name(s, {var = false, constant = false, mod = true}) }},
    {"\\b[a-z][a-zA-Z]*", (s : String) { 
      Mint.Token::Name(s, {var = true, constant = false, mod = false}) }},
    {"\\b[a-z][a-zA-Z_]*", (s : String) { 
      Mint.Token::Name(s, {var = false, constant = false, mod = false}) }},
    {"\\S", (s : String) { Mint.Token::Invalid(s,
      "This character is not allowed") }}
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