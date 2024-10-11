defmodule MeetupWeb.SpeakerLiveTest do
  use MeetupWeb.ConnCase

  import Phoenix.LiveViewTest
  import Meetup.ConfFixtures

  @create_attrs %{name: "some name", position: "some position", age: 42, is_prepared_well: true, super_power: "some super_power", company: "some company", topic: "some topic"}
  @update_attrs %{name: "some updated name", position: "some updated position", age: 43, is_prepared_well: false, super_power: "some updated super_power", company: "some updated company", topic: "some updated topic"}
  @invalid_attrs %{name: nil, position: nil, age: nil, is_prepared_well: false, super_power: nil, company: nil, topic: nil}

  defp create_speaker(_) do
    speaker = speaker_fixture()
    %{speaker: speaker}
  end

  describe "Index" do
    setup [:create_speaker]

    test "lists all speakers", %{conn: conn, speaker: speaker} do
      {:ok, _index_live, html} = live(conn, ~p"/speakers")

      assert html =~ "Listing Speakers"
      assert html =~ speaker.name
    end

    test "saves new speaker", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/speakers")

      assert index_live |> element("a", "New Speaker") |> render_click() =~
               "New Speaker"

      assert_patch(index_live, ~p"/speakers/new")

      assert index_live
             |> form("#speaker-form", speaker: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#speaker-form", speaker: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/speakers")

      html = render(index_live)
      assert html =~ "Speaker created successfully"
      assert html =~ "some name"
    end

    test "updates speaker in listing", %{conn: conn, speaker: speaker} do
      {:ok, index_live, _html} = live(conn, ~p"/speakers")

      assert index_live |> element("#speakers-#{speaker.id} a", "Edit") |> render_click() =~
               "Edit Speaker"

      assert_patch(index_live, ~p"/speakers/#{speaker}/edit")

      assert index_live
             |> form("#speaker-form", speaker: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#speaker-form", speaker: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/speakers")

      html = render(index_live)
      assert html =~ "Speaker updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes speaker in listing", %{conn: conn, speaker: speaker} do
      {:ok, index_live, _html} = live(conn, ~p"/speakers")

      assert index_live |> element("#speakers-#{speaker.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#speakers-#{speaker.id}")
    end
  end

  describe "Show" do
    setup [:create_speaker]

    test "displays speaker", %{conn: conn, speaker: speaker} do
      {:ok, _show_live, html} = live(conn, ~p"/speakers/#{speaker}")

      assert html =~ "Show Speaker"
      assert html =~ speaker.name
    end

    test "updates speaker within modal", %{conn: conn, speaker: speaker} do
      {:ok, show_live, _html} = live(conn, ~p"/speakers/#{speaker}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Speaker"

      assert_patch(show_live, ~p"/speakers/#{speaker}/show/edit")

      assert show_live
             |> form("#speaker-form", speaker: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#speaker-form", speaker: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/speakers/#{speaker}")

      html = render(show_live)
      assert html =~ "Speaker updated successfully"
      assert html =~ "some updated name"
    end
  end
end
