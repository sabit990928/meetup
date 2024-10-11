defmodule MeetupWeb.SpeakerLive.FormComponent do
  use MeetupWeb, :live_component

  alias Meetup.Conf

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage speaker records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="speaker-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:age]} type="number" label="Age" />
        <.input field={@form[:is_prepared_well]} type="checkbox" label="Is prepared well" />
        <.input field={@form[:super_power]} type="text" label="Super power" />
        <.input field={@form[:company]} type="text" label="Company" />
        <.input field={@form[:topic]} type="text" label="Topic" />
        <.input field={@form[:position]} type="text" label="Position" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Speaker</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{speaker: speaker} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Conf.change_speaker(speaker))
     end)}
  end

  @impl true
  def handle_event("validate", %{"speaker" => speaker_params}, socket) do
    changeset = Conf.change_speaker(socket.assigns.speaker, speaker_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"speaker" => speaker_params}, socket) do
    save_speaker(socket, socket.assigns.action, speaker_params)
  end

  defp save_speaker(socket, :edit, speaker_params) do
    case Conf.update_speaker(socket.assigns.speaker, speaker_params) do
      {:ok, speaker} ->
        notify_parent({:saved, speaker})

        {:noreply,
         socket
         |> put_flash(:info, "Speaker updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_speaker(socket, :new, speaker_params) do
    case Conf.create_speaker(speaker_params) do
      {:ok, speaker} ->
        notify_parent({:saved, speaker})

        {:noreply,
         socket
         |> put_flash(:info, "Speaker created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
