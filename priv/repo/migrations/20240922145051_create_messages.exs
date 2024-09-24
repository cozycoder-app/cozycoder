defmodule CozyCoder.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :chat_id, references("chats", type: :binary_id)
      add :user_message, :string
      add :assistant_response, :string

      timestamps(type: :utc_datetime)
    end
  end
end
