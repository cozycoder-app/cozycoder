defmodule CozyCoder.Chats.Message do
  alias CozyCoder.Chats.Chat
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "messages" do
    field :user_message, :string
    field :assistant_response, :string

    belongs_to :chat, Chat
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:user_message, :assistant_response])
    |> validate_required([:user_message])
  end

  @doc false
  def changeset_new(chat, attrs) do
    chat
    |> Ecto.build_assoc(:messages)
    |> cast(attrs, [:user_message, :assistant_response])
    |> validate_required([:user_message])
  end
end
