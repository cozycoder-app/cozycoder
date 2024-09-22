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
end
