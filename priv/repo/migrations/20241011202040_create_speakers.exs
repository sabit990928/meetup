defmodule Meetup.Repo.Migrations.CreateSpeakers do
  use Ecto.Migration

  def change do
    create table(:speakers) do
      add :name, :string
      add :age, :integer
      add :is_prepared_well, :boolean, default: false, null: false
      add :super_power, :string
      add :company, :string
      add :topic, :string
      add :position, :string

      timestamps(type: :utc_datetime)
    end
  end
end
