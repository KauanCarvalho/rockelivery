defmodule Rockelivery.Repo do
  @moduledoc false

  use Ecto.Repo,
    otp_app: :rockelivery,
    adapter: Ecto.Adapters.Postgres
end
