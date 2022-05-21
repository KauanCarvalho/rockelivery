defmodule RockeliveryWeb.UsersViewTest do
  @moduledoc false

  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias RockeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)
    token = "token"

    response = render(UsersView, "create.json", user: user, token: token)

    assert %{
             message: "User created!",
             user: %Rockelivery.User{
               address: "Address",
               age: 23,
               cep: "11111111",
               cpf: "22222222222",
               email: "bar@gmail.com",
               id: "438339ba-4a4e-4190-a5c8-3690abcedfbf",
               inserted_at: nil,
               name: "Foo",
               password: "123456",
               password_hash: nil,
               updated_at: nil
             },
             token: "token"
           } == response
  end
end
