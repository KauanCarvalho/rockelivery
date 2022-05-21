defmodule Rockelivery.Users.Get do
  @moduledoc false

  alias Rockelivery.{Error, Repo, User}

  # Another way.
  # def by_id(id) do
  #   with {:ok, _uuid}   <- UUID.cast(id),
  #        %User{} = user <- Repo.get(User, id) do
  #     {:ok, user}
  #   else
  #     :error -> {:error, %{status: :bad_request, result: "Invalid UUID format"}}
  #     nil    -> {:error, %{status: :not_found, result: "User not found!"}}
  #   end
  # end

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> {:ok, user}
    end
  end
end
