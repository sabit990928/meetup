defmodule Meetup.Conf.Speaker do
  use Ecto.Schema
  import Ecto.Changeset

  schema "speakers" do
    field :name, :string
    field :position, :string
    field :age, :integer
    field :is_prepared_well, :boolean, default: false
    field :super_power, :string
    field :company, :string
    field :topic, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(speaker, attrs) do
    speaker
    |> cast(attrs, [:name, :age, :is_prepared_well, :super_power, :company, :topic, :position])
    |> validate_required([
      :name,
      :age,
      :is_prepared_well,
      :super_power,
      :company,
      :topic,
      :position
    ])
    |> validate_number(:age, greater_than: 0)
    |> validate_number(:age, less_than: 103)
    |> validate_inclusion(:is_prepared_well, [false], message: "Қойщищ радной")
  end
end
