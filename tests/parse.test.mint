suite "Mint parse" {
  test "empty string" {
    with Test.Context {
      of(Mint.parse("")) |> assertEqual({elems = []})
    }
  }
}