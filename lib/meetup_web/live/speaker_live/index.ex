defmodule MeetupWeb.SpeakerLive.Index do
  use MeetupWeb, :live_view

  alias Meetup.Conf
  alias Meetup.Conf.Speaker

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :speakers, Conf.list_speakers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Speaker")
    |> assign(:speaker, Conf.get_speaker!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Speaker")
    |> assign(:speaker, %Speaker{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Speakers")
    |> assign(:speaker, nil)
  end

  @impl true
  def handle_info({MeetupWeb.SpeakerLive.FormComponent, {:saved, speaker}}, socket) do
    {:noreply, stream_insert(socket, :speakers, speaker)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    speaker = Conf.get_speaker!(id)
    {:ok, _} = Conf.delete_speaker(speaker)

    {:noreply, stream_delete(socket, :speakers, speaker)}
  end
end
