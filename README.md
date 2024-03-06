# GoogleAiEx

Elixir study integration to Google's Vertex AI, and maybe other APIs on the future

## Usage example with mix

```elixir
iex -S mix

iex(1)> VertexAI.request "Im using you to test your API, how do you feel about it?"
%{
  input_tokens: 15,
  output_tokens: 68,
  prediction: " Pleased to be of assistance."
}
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `google_ai_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:google_ai_ex, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/google_ai_ex>.
