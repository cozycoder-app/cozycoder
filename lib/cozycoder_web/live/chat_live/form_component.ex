defmodule CozyCoderWeb.ChatLive.FormComponent do
  use CozyCoderWeb, :live_component

  alias CozyCoder.Chats

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage chat records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="chat-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Chat</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{chat: chat} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Chats.change_chat(chat))
     end)}
  end

  @impl true
  def handle_event("validate", %{"chat" => chat_params}, socket) do
    changeset = Chats.change_chat(socket.assigns.chat, chat_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"chat" => chat_params}, socket) do
    save_chat(socket, socket.assigns.action, chat_params)
  end

  defp save_chat(socket, :edit, chat_params) do
    case Chats.update_chat(socket.assigns.chat, chat_params) do
      {:ok, chat} ->
        notify_parent({:saved, chat})

        {:noreply,
         socket
         |> put_flash(:info, "Chat updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_chat(socket, :new, chat_params) do
    case Chats.create_chat(chat_params) do
      {:ok, chat} ->
        notify_parent({:saved, chat})

        {:noreply,
         socket
         |> put_flash(:info, "Chat created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
