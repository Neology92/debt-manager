defmodule DebtManager.Flows do
  @moduledoc """
  The Flows context.
  """

  import Ecto.Query, warn: false
  alias DebtManager.Repo

  alias DebtManager.Flows.Debt

  @doc """
  Returns the list of debts.

  ## Examples

      iex> list_debts()
      [%Debt{}, ...]

  """
  def list_debts do
    Repo.all(Debt)
  end

  @doc """
  Gets a single debt.

  Raises `Ecto.NoResultsError` if the Debt does not exist.

  ## Examples

      iex> get_debt!(123)
      %Debt{}

      iex> get_debt!(456)
      ** (Ecto.NoResultsError)

  """
  def get_debt!(id), do: Repo.get!(Debt, id)

  def get_debts_between_users(u1_id, u2_id) do
    query =
      from d in Debt,
        where:
          (d.debtor_id == ^u1_id or d.debtor_id == ^u2_id) and
            (d.creditor_id == ^u2_id or d.creditor_id == ^u1_id),
        select: d

    Repo.all(query)
  end

  @doc """
  Creates a debt.
  """
  def create_debt(attrs \\ %{}, user, debtor_id) do
    debt_tuple =
      user
      |> Ecto.build_assoc(:lends, debtor_id: debtor_id)
      |> Debt.changeset(attrs)
      |> Repo.insert()

    case debt_tuple do
      {:ok, debt} ->
        # TODO: Make sure everything's alright - Sensitive place!
        DebtManager.Accounts.update_users_balances(debt)

      true ->
        nil
    end

    debt_tuple
  end

  @doc """
  Updates a debt.

  ## Examples

      iex> update_debt(debt, %{field: new_value})
      {:ok, %Debt{}}

      iex> update_debt(debt, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_debt(%Debt{} = debt, attrs) do
    debt
    |> Debt.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a debt.

  ## Examples

      iex> delete_debt(debt)
      {:ok, %Debt{}}

      iex> delete_debt(debt)
      {:error, %Ecto.Changeset{}}

  """
  def delete_debt(%Debt{} = debt) do
    Repo.delete(debt)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking debt changes.

  ## Examples

      iex> change_debt(debt)
      %Ecto.Changeset{data: %Debt{}}

  """
  def change_debt(%Debt{} = debt, attrs \\ %{}) do
    Debt.changeset(debt, attrs)
  end

  alias DebtManager.Flows.Payoff

  @doc """
  Returns the list of payoffs.

  ## Examples

      iex> list_payoffs()
      [%Payoff{}, ...]

  """
  def list_payoffs do
    Repo.all(Payoff)
  end

  @doc """
  Gets a single payoff.

  Raises `Ecto.NoResultsError` if the Payoff does not exist.

  ## Examples

      iex> get_payoff!(123)
      %Payoff{}

      iex> get_payoff!(456)
      ** (Ecto.NoResultsError)

  """
  def get_payoff!(id), do: Repo.get!(Payoff, id)

  def get_payoffs_between_users(u1_id, u2_id) do
    query =
      from d in Payoff,
        where:
          (d.debtor_id == ^u1_id or d.debtor_id == ^u2_id) and
            (d.creditor_id == ^u2_id or d.creditor_id == ^u1_id),
        select: d

    Repo.all(query)
  end

  @doc """
  Creates a payoff.
  """
  def create_payoff(attrs \\ %{}, user, creditor_id) do
    payoff_tuple =
      user
      |> Ecto.build_assoc(:payoffs, creditor_id: creditor_id)
      |> Payoff.changeset(attrs)
      |> Repo.insert()

    case payoff_tuple do
      {:ok, payoff} ->
        # TODO: Make sure everything's alright - Sensitive place!
        DebtManager.Accounts.update_users_balances(payoff)

      {:error, %Ecto.Changeset{} = changeset} ->
        nil
    end

    payoff_tuple
  end

  @doc """
  Updates a payoff.

  ## Examples

      iex> update_payoff(payoff, %{field: new_value})
      {:ok, %Payoff{}}

      iex> update_payoff(payoff, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_payoff(%Payoff{} = payoff, attrs) do
    payoff
    |> Payoff.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a payoff.

  ## Examples

      iex> delete_payoff(payoff)
      {:ok, %Payoff{}}

      iex> delete_payoff(payoff)
      {:error, %Ecto.Changeset{}}

  """
  def delete_payoff(%Payoff{} = payoff) do
    Repo.delete(payoff)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking payoff changes.

  ## Examples

      iex> change_payoff(payoff)
      %Ecto.Changeset{data: %Payoff{}}

  """
  def change_payoff(%Payoff{} = payoff, attrs \\ %{}) do
    Payoff.changeset(payoff, attrs)
  end
end
