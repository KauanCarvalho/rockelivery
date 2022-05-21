defmodule Rockelivery.Orders.Create do
  @moduledoc false

  alias Rockelivery.{Error, Item, Order, Repo}
  alias Rockelivery.Orders.ValidateAndMultiply

  import Ecto.Query

  def call(%{"items" => items_params} = params) do
    items_ids = Enum.map(items_params, fn item_param -> item_param["id"] end)

    query = from item in Item, where: item.id in ^items_ids

    query
    |> Repo.all()
    |> ValidateAndMultiply.call(items_ids, items_params)
    |> handle_items(params)
  end

  defp handle_items({:ok, items}, params) do
    params
    |> Order.changeset(items)
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_items({:error, result}, _params), do: {:error, Error.build(:bad_request, result)}

  defp handle_insert({:ok, %Order{} = order}), do: {:ok, order}
  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}
end
