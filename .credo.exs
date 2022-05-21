%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/", "src/", "test/", "web/", "apps/", "live/"],
        excluded: [
          ~r"/_build/",
          ~r"/deps/",
          ~r"/errors/exceptions.ex"
        ]
      },
      strict: true,
      color: true,
      checks: [
        {Credo.Check.Warning.ApplicationConfigInModuleAttribute, false},
        {Credo.Check.Refactor.LongQuoteBlocks, false}
      ]
    }
  ]
}
