defmodule RockeliveryWeb.UsersControllerTest do
  @moduledoc false

  use RockeliveryWeb.ConnCase, async: true

  import Mox
  import Rockelivery.Factory

  alias Rockelivery.ViaCep.ClientMock
  alias RockeliveryWeb.Auth.Guardian

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = %{
        "address" => "Address",
        "age" => 23,
        "cep" => "11111111",
        "cpf" => "22222222222",
        "name" => "Foo",
        "email" => "bar@gmail.com",
        "password" => "123456"
      }

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user" => %{
                 "address" => "Address",
                 "age" => 23,
                 "cep" => "11111111",
                 "cpf" => "22222222222",
                 "email" => "bar@gmail.com",
                 "id" => _id,
                 "name" => "Foo"
               }
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      params = %{
        "address" => "Address",
        "age" => 10,
        "cep" => "11111111",
        "cpf" => "22222222222",
        "name" => "Foo",
        "email" => "bar@gmail.com",
        "password" => "123456"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "age" => ["must be greater than or equal to 18"]
        }
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    setup %{conn: conn} do
      user = insert(:user)

      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "when there is a user with the given id, deletes the user", %{conn: conn} do
      id = "438339ba-4a4e-4190-a5c8-3690abcedfbf"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end
  end
end
