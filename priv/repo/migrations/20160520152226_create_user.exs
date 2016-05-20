defmodule Rumbl.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :password_hash, :string
      add :username, :string, null: false

      timestamps
    end

    create unique_index(:users, [:username])
  end
end
