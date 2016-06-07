defmodule Rumbl.TestHelpers do
  alias Rumbl.Repo

  def insert_user(attrs \\ %{}) do
    changes = Dict.merge(%{
        name: "Some user",
        username: "user#{Base.encode16(:crypto.rand_bytes(8))}",
        password: "password"
      }, attrs)

      %Rumbl.User{}
      |> Rumbl.User.registration_changeset(changes)
      |> Repo.insert!()
  end

  def insert_video(user, attrs \\ %{}) do
    category = Repo.insert!(%Rumbl.Category{name: "category#{Base.encode16(:crypto.rand_bytes(8))}"})

    user
    |> Ecto.build_assoc(:videos, Dict.merge(%{category_id: category.id}, attrs))
    |> Repo.insert!()
  end
end
