import Config

config :google_ai_ex, env: Mix.env()
config :logger, :console, level: :debug

config :google_ai_ex, GoogleAiEx,
  # gcloud auth print-access-token
  google_application_credential: "",
  project_id: "",
  api_endpoint: "",
  location_id: ""

import_config "#{config_env()}.exs"
