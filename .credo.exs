%{
  configs: [
    %{
      checks: [
        {Credo.Check.Readability.MaxLineLength, ignore_string: true, ignore_specs: true},
      ]
    }
  ]
}
