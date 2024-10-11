defmodule MeetupWeb.SpeakerLive.Show do
  use MeetupWeb, :live_view

  alias Meetup.Conf

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:speaker, Conf.get_speaker!(id))}
  end

  defp page_title(:show), do: "Show Speaker"
  defp page_title(:edit), do: "Edit Speaker"
end
