defmodule Rockelivery.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      "address" => "Address",
      "age" => 23,
      "cep" => "11111111",
      "cpf" => "22222222222",
      "name" => "Foo",
      "email" => "bar@gmail.com",
      "password" => "123456"
    }
  end

  def user_factory do
    %User{
      id: "438339ba-4a4e-4190-a5c8-3690abcedfbf",
      address: "Address",
      age: 23,
      cep: "11111111",
      cpf: "22222222222",
      name: "Foo",
      email: "bar@gmail.com",
      password: "123456"
    }
  end

  def cep_info_factory do
    %{
      "bairro" => "Sé",
      "cep" => "01001-000",
      "complemento" => "lado ímpar",
      "ddd" => "11",
      "gia" => "1004",
      "ibge" => "3550308",
      "localidade" => "São Paulo",
      "logradouro" => "Praça da Sé",
      "siafi" => "7107",
      "uf" => "SP"
    }
  end
end
