defmodule CozyCoder.ChatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CozyCoder.Chats` context.
  """

  @doc """
  Generate a chat.
  """
  def chat_fixture(attrs \\ %{}) do
    {:ok, chat} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> CozyCoder.Chats.create_chat()

    chat
  end

  @doc """
    Gernerate a message for a chat.
  """
  def message_fixture(chat, attrs \\ %{}) do
    attrs =
      attrs
      |> Enum.into(%{user_message: "Can you say hello world?"})

    {:ok, message} = CozyCoder.Chats.create_message(chat, attrs)

    message
  end
end
