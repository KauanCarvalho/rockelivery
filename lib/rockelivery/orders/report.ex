defmodule Rockelivery.Orders.Report do
  @moduledoc false

  import Ecto.Query

  alias Rockelivery.{Item, Order, Repo}
  alias Rockelivery.Orders.TotalPrice

  @default_block_size 500
  @default_filename "report.csv"

  def create(filename \\ @default_filename) do
    query = from(order in Order, order_by: order.user_id)

    {:ok, order_list} =
      Repo.transaction(
        fn ->
          query
          |> Repo.stream(max_rows: @default_block_size)
          |> Stream.chunk_every(@default_block_size)
          |> Stream.flat_map(fn chunk -> Repo.preload(chunk, :items) end)
          |> Enum.into([])
          |> Enum.map(&parse_line/1)
        end,
        timeout: :infinity
      )

    File.write(filename, order_list)
  end

  defp parse_line(%Order{user_id: user_id, payment_method: payment_method, items: items}) do
    total_price = TotalPrice.calculate(items)

    items_string = Enum.map(items, &items_string/1)

    "#{user_id},#{payment_method},#{items_string}#{total_price}\n"
  end

  defp items_string(%Item{category: category, description: description, price: price}) do
    "#{category},#{description},#{price},"
  end
end
