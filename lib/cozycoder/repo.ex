defmodule CozyCoder.Repo do
  use Ecto.Repo,
    otp_app: :cozycoder,
    adapter: Ecto.Adapters.Postgres
end
