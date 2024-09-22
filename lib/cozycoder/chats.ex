defmodule CozyCoder.Chats do
  @moduledoc """
  The Chats context.
  """

  import Ecto.Query, warn: false
  alias CozyCoder.Chats.Message
  alias CozyCoder.Repo

  alias CozyCoder.Chats.Chat

  @doc """
  Returns the list of chats.

  ## Examples

      iex> list_chats()
      [%Chat{}, ...]

  """
  def list_chats do
    Repo.all(Chat)
  end

  @doc """
  Gets a single chat.

  Raises `Ecto.NoResultsError` if the Chat does not exist.

  ## Examples

      iex> get_chat!(123)
      %Chat{}

      iex> get_chat!(456)
      ** (Ecto.NoResultsError)

  """
  def get_chat!(id), do: Repo.get!(Chat, id)

  @doc """
  Creates a chat.

  ## Examples

      iex> create_chat(%{field: value})
      {:ok, %Chat{}}

      iex> create_chat(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_chat(attrs \\ %{}) do
    %Chat{}
    |> Chat.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a chat.

  ## Examples

      iex> update_chat(chat, %{field: new_value})
      {:ok, %Chat{}}

      iex> update_chat(chat, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_chat(%Chat{} = chat, attrs) do
    chat
    |> Chat.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a chat.

  ## Examples

      iex> delete_chat(chat)
      {:ok, %Chat{}}

      iex> delete_chat(chat)
      {:error, %Ecto.Changeset{}}

  """
  def delete_chat(%Chat{} = chat) do
    Repo.delete(chat)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking chat changes.

  ## Examples

      iex> change_chat(chat)
      %Ecto.Changeset{data: %Chat{}}

  """
  def change_chat(%Chat{} = chat, attrs \\ %{}) do
    Chat.changeset(chat, attrs)
  end

  @doc """
    Creates a message in the given chat.

    ## Examples

    iex> create_message(chat, %{user_message: "foo"}
    {:ok, %Message{}}

    iex> create_message(chat,%{user_message: bad_value}
    {:error, %Ecto.Changeset{}}

  """
  def create_message(%Chat{} = chat, attrs \\ %{}) do
    chat
    |> Message.changeset_new(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a message.

  ## Examples

      iex> update_message(message, %{field: new_value})
      {:ok, %Message{}}

      iex> update_message(message, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_message(%Message{} = message, attrs \\ %{}) do
    message
    |> Message.changeset(attrs)
    |> Repo.update()
  end

  @doc """
    Loads the messages of the given chat.

    ## Examples

    iex> load_messages(chat)
    %Chat{}
  """
  def load_messages(chat) do
    unless Ecto.assoc_loaded?(chat.messages) do
      Repo.preload(chat, :messages)
    else
      chat
    end
  end
end
