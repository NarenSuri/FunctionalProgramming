defmodule Discuss.Repo.Migrations.AddTopicsTable do
  use Ecto.Migration

  def change do
	   create table(:topicstable) do
		add :title , :string
	   end
  end
end
