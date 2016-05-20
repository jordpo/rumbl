defmodule Rumbl.User do
  use Rumbl.Web, :model

  schema "users" do
    field :name, :string
    field :password_hash, :string
    field :username, :string
    field :password, :string, virtual: true

    timestamps
  end

  @required_fields ~w(name username)
  @optional_fields ~w(password)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:username, min: 1, max: 20)
  end
end
