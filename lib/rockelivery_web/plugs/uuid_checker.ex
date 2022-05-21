defmodule RockeliveryWeb.Plugs.UUIDChecker do
  @moduledoc false

  import Plug.Conn

  alias Ecto.UUID
  alias Plug.Conn
  alias Rockelivery.Error

  def init(options), do: options

  def call(%Conn{params: %{"id" => id}} = conn, _options) do
    case UUID.cast(id) do
      :error -> render_error(conn)
      {:ok, _uuid} -> conn
    end
  end

  def call(conn, _options), do: conn

  defp render_error(conn) do
    error = Error.build_id_format_error()
    body = Jason.encode!(%{message: error.result})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(error.status, body)
    |> halt()
  end
end