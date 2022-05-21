defmodule Rockelivery.Users.CreateTest do
  @moduledoc false

  use Rockelivery.DataCase, async: true

  import Mox
  import Rockelivery.Factory

  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Create
  alias Rockelivery.ViaCep.ClientMock

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = build(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      response = Create.call(params)

      assert {:ok, %User{id: _id, age: 23, email: "bar@gmail.com"}} = response
    end

    test "when there are invalid params, returns an error" do
      params = build(:user_params, %{"age" => 10, "password" => "123"})

      response = Create.call(params)
      {:error, %Error{status: status, result: changeset}} = response

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert status == :bad_request
      assert errors_on(changeset) == expected_response
    end
  end
end
