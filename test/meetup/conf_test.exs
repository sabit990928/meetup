defmodule Meetup.ConfTest do
  use Meetup.DataCase

  alias Meetup.Conf

  describe "speakers" do
    alias Meetup.Conf.Speaker

    import Meetup.ConfFixtures

    @invalid_attrs %{name: nil, position: nil, age: nil, is_prepared_well: nil, super_power: nil, company: nil, topic: nil}

    test "list_speakers/0 returns all speakers" do
      speaker = speaker_fixture()
      assert Conf.list_speakers() == [speaker]
    end

    test "get_speaker!/1 returns the speaker with given id" do
      speaker = speaker_fixture()
      assert Conf.get_speaker!(speaker.id) == speaker
    end

    test "create_speaker/1 with valid data creates a speaker" do
      valid_attrs = %{name: "some name", position: "some position", age: 42, is_prepared_well: true, super_power: "some super_power", company: "some company", topic: "some topic"}

      assert {:ok, %Speaker{} = speaker} = Conf.create_speaker(valid_attrs)
      assert speaker.name == "some name"
      assert speaker.position == "some position"
      assert speaker.age == 42
      assert speaker.is_prepared_well == true
      assert speaker.super_power == "some super_power"
      assert speaker.company == "some company"
      assert speaker.topic == "some topic"
    end

    test "create_speaker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Conf.create_speaker(@invalid_attrs)
    end

    test "update_speaker/2 with valid data updates the speaker" do
      speaker = speaker_fixture()
      update_attrs = %{name: "some updated name", position: "some updated position", age: 43, is_prepared_well: false, super_power: "some updated super_power", company: "some updated company", topic: "some updated topic"}

      assert {:ok, %Speaker{} = speaker} = Conf.update_speaker(speaker, update_attrs)
      assert speaker.name == "some updated name"
      assert speaker.position == "some updated position"
      assert speaker.age == 43
      assert speaker.is_prepared_well == false
      assert speaker.super_power == "some updated super_power"
      assert speaker.company == "some updated company"
      assert speaker.topic == "some updated topic"
    end

    test "update_speaker/2 with invalid data returns error changeset" do
      speaker = speaker_fixture()
      assert {:error, %Ecto.Changeset{}} = Conf.update_speaker(speaker, @invalid_attrs)
      assert speaker == Conf.get_speaker!(speaker.id)
    end

    test "delete_speaker/1 deletes the speaker" do
      speaker = speaker_fixture()
      assert {:ok, %Speaker{}} = Conf.delete_speaker(speaker)
      assert_raise Ecto.NoResultsError, fn -> Conf.get_speaker!(speaker.id) end
    end

    test "change_speaker/1 returns a speaker changeset" do
      speaker = speaker_fixture()
      assert %Ecto.Changeset{} = Conf.change_speaker(speaker)
    end
  end
end
