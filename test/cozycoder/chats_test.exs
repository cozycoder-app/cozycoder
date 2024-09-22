defmodule CozyCoder.ChatsTest do
  alias CozyCoder.Chats.Message
  use CozyCoder.DataCase

  alias CozyCoder.Chats

  describe "chats" do
    alias CozyCoder.Chats.Chat

    import CozyCoder.ChatsFixtures

    @invalid_attrs %{title: nil}

    test "list_chats/0 returns all chats" do
      chat = chat_fixture()
      assert Chats.list_chats() == [chat]
    end

    test "get_chat!/1 returns the chat with given id" do
      chat = chat_fixture()
      assert Chats.get_chat!(chat.id) == chat
    end

    test "create_chat/1 with valid data creates a chat" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Chat{} = chat} = Chats.create_chat(valid_attrs)
      assert chat.title == "some title"
    end

    test "create_chat/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chats.create_chat(@invalid_attrs)
    end

    test "update_chat/2 with valid data updates the chat" do
      chat = chat_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Chat{} = chat} = Chats.update_chat(chat, update_attrs)
      assert chat.title == "some updated title"
    end

    test "update_chat/2 with invalid data returns error changeset" do
      chat = chat_fixture()
      assert {:error, %Ecto.Changeset{}} = Chats.update_chat(chat, @invalid_attrs)
      assert chat == Chats.get_chat!(chat.id)
    end

    test "delete_chat/1 deletes the chat" do
      chat = chat_fixture()
      assert {:ok, %Chat{}} = Chats.delete_chat(chat)
      assert_raise Ecto.NoResultsError, fn -> Chats.get_chat!(chat.id) end
    end

    test "change_chat/1 returns a chat changeset" do
      chat = chat_fixture()
      assert %Ecto.Changeset{} = Chats.change_chat(chat)
    end

    test "create_message/2 with valid data adds message to a chat" do
      valid_attrs = %{user_message: "Can you say hello world?"}

      assert {:ok, %Message{} = message} = Chats.create_message(chat_fixture(), valid_attrs)
      assert message.user_message == "Can you say hello world?"
    end

    test "create_message/2 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chats.create_message(chat_fixture(), %{})
    end

    test "update_message/2 with valid data updates the chat" do
      message = message_fixture(chat_fixture())
      update_attrs = %{assistant_response: "Yes, of course. Her is \"Hello world\""}

      assert {:ok, %Message{} = message} = Chats.update_message(message, update_attrs)
      assert message.assistant_response == "Yes, of course. Her is \"Hello world\""
    end

    test "load_messages/1 loads all messages of the given chat" do
      chat = chat_fixture()
      first_message = message_fixture(chat)
      second_message = message_fixture(chat)

      chat = Chats.load_messages(chat)
      assert chat.messages == [first_message, second_message]

      # Ensure load_messages returns always the chat.
      chat = Chats.load_messages(chat)
      assert chat.messages == [first_message, second_message]
    end
  end
end
