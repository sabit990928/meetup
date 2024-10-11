defmodule Meetup.ConfFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Meetup.Conf` context.
  """

  @doc """
  Generate a speaker.
  """
  def speaker_fixture(attrs \\ %{}) do
    {:ok, speaker} =
      attrs
      |> Enum.into(%{
        age: 42,
        company: "some company",
        is_prepared_well: true,
        name: "some name",
        position: "some position",
        super_power: "some super_power",
        topic: "some topic"
      })
      |> Meetup.Conf.create_speaker()

    speaker
  end
end
