component Main {
  state code : String = ""

  get compiled { code |> Mint.tokens |> Mint.Grammar:FILE |> Mint.ParseResult.toString }

  style app {
    display: flex;
    justify-content: stretch;
    align-items: center;
    color: white;

    background-color: #282C34;
    height: 100vh;
    width: 100vw;

    font-family: Open Sans;
    font-weight: bold;
  }

  fun render : Html {
    <div::app>
      <div>
        <textarea rows="30" cols="80" value={code} onChange={
           (event : Html.Event){next { code = Dom.getValue(event.currentTarget) } }}>

        </textarea>
      </div>
      <aside>
        <{compiled}>
      </aside>
    </div>
  }
}
