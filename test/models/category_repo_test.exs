defmodule Rumbl.CategoryRepoTest do
  # non-side effect free test
  # testing the constraints on the repo
  use Rumbl.ModelCase

  alias Rumbl.Category

  @valid_attrs %{name: "Comedy"}

  test "converts unique constraint on name to changeset error" do
    Repo.insert!(%Category{name: "Comedy"})
    attrs = Map.put(@valid_attrs, :name, "Comedy")
    changeset = Category.changeset(%Category{}, attrs)
    assert {:error, changeset} = Repo.insert(changeset)
    assert {:name, "has already been taken"} in changeset.errors
  end

  test "alphabetical/1 orders by name" do
    Repo.insert!(%Category{name: "c"})
    Repo.insert!(%Category{name: "a"})
    Repo.insert!(%Category{name: "b"})

    query = Category |> Category.alphabetical()
    query = from c in query, select: c.name
    assert Repo.all(query) == ~w(a b c)
  end
end
