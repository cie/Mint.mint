record Mint.File {
  elems: Array(Mint.FileElem)
}

enum Mint.FileElem {
  Module(Mint.Module)
}

record Mint.Module {
  name : String,
  elems : Array(Mint.ModuleElem)
}

enum Mint.ModuleElem {
  Fun(Mint.Fun)
}

record Mint.Fun {
  name : String
}

enum Mint.Node {
  File(Mint.File)
}

module Mint.AST {
  fun fileToString(n : Mint.File) {
    n.elems |> Array.map(fileElemToString) |> String.join("\n\n")
  }
  fun fileElemToString(n : Mint.FileElem) {
    case (n) {
      Mint.FileElem::Module(m) => moduleToString(m)
    }
  }
  fun moduleToString(n : Mint.Module) {
    "module #{n.name} {\n#{
      (n.elems |> Array.map(moduleElemToString) |> String.join("\n\n"))
    }\n}"
  }
  fun moduleElemToString(n : Mint.ModuleElem) {
    case (n) {
      Mint.ModuleElem::Fun(m) => funToString(m)
    }
  }
  fun funToString(n : Mint.Fun) {
    "fun #{n.name}"
  }
}