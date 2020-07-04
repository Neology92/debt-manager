defmodule DebtManager.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias DebtManager.Repo

  alias DebtManager.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  def get_users_names_list() do
    list_users()
    |> Enum.map(fn u -> %{u.id => u.name} end)
    |> Enum.reduce(fn x, y -> Map.merge(x, y) end)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def update_user_balances(%User{} = user, attrs) do
    user
    |> User.changeset_balances(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def update_users_balances(%name{debtor_id: debtor_id, creditor_id: creditor_id, amount: amount}) do
    debtor = get_user!(debtor_id)
    creditor = get_user!(creditor_id)

    name =
      name
      |> Module.split()
      |> List.last()

    amount = if name == "Payoff", do: -amount, else: amount

    new_debtor_balances =
      Map.update(debtor.balances, Integer.to_string(creditor_id), -amount, &(&1 - amount))

    new_creditor_balances =
      Map.update(creditor.balances, Integer.to_string(debtor_id), amount, &(&1 + amount))

    update_user_balances(debtor, %{balances: new_debtor_balances})
    update_user_balances(creditor, %{balances: new_creditor_balances})
  end

  def generate_users_options(current_user) do
    list_users()
    |> Enum.map(&{&1.name, &1.id})
    |> Enum.filter(fn {_name, id} -> id != current_user.id end)
  end
end
