defmodule Rumbl.UserRepoTest do
  # non-side effect free test
  # testing the constraints on the repo
  use Rumbl.ModelCase

  alias Rumbl.User

  @valid_attrs %{name: "some content", username: "some content"}

  test "converts unique constraint on username to changeset error" do
    insert_user(username: "eric")
    attrs = Map.put(@valid_attrs, :username, "eric")
    changeset = User.changeset(%User{}, attrs)
    assert {:error, changeset} = Repo.insert(changeset)
    assert {:username, "has already been taken"} in changeset.errors
  end
end
