defmodule VertexAI do
  @moduledoc false

  @default_model_id "text-bison"
  @response_count 1
  @default_token 1024
  @default_temperature 0.9
  @default_topP 1

  def request(message, model_id \\ @default_model_id) do
    body = build_body(message)
    url = build_url(model_id)
    headers = build_headers()

    response =
      Req.new(base_url: url)
      |> Req.Request.put_headers(headers)
      |> Req.post!(json: body)

    case response.status do
      200 ->
        process_response(response)

      _ ->
        response
    end
  end

  defp build_url(model_id) do
    location_id = Application.fetch_env!(:google_ai_ex, GoogleAiEx)[:location_id]
    api_endpoint = Application.fetch_env!(:google_ai_ex, GoogleAiEx)[:api_endpoint]
    project_id = Application.fetch_env!(:google_ai_ex, GoogleAiEx)[:project_id]

    "https://#{api_endpoint}/v1/projects/#{project_id}/locations/#{location_id}/publishers/google/models/#{model_id}:predict"
  end

  defp build_headers do
    google_api_key = Application.fetch_env!(:google_ai_ex, GoogleAiEx)[:google_application_credential]

    [
      {"content-type", "application/json"},
      {"authorization", "Bearer " <> google_api_key}
    ]
  end

  defp build_body(message) do
    %{
      "instances" => [
        %{
          "prompt" => message
        }
      ],
      "parameters" => %{
        "candidateCount" => @response_count,
        "maxOutputTokens" => @default_token,
        "temperature" => @default_temperature,
        "topP" => @default_topP
      }
    }
  end

  defp process_response(response) do
    body = response.body

    pred =
      body
      |> Map.get("predictions")
      |> hd()
      |> Map.get("content")

    input_tokens =
      body
      |> Map.get("metadata", %{})
      |> Map.get("tokenMetadata", %{})
      |> Map.get("inputTokenCount", %{})
      |> Map.get("totalTokens", %{})

    output_tokens =
      body
      |> Map.get("metadata", %{})
      |> Map.get("tokenMetadata", %{})
      |> Map.get("outputTokenCount", %{})
      |> Map.get("totalTokens", %{})

    %{
      prediction: pred,
      input_tokens: input_tokens,
      output_tokens: output_tokens
    }
  end
end
