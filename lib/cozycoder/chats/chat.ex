defmodule CozyCoder.Chats.Chat do
  alias CozyCoder.Chats.Message
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "chats" do
    field :title, :string

    has_many :messages, Message
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
