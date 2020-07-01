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

  @doc """
  Creates a debt.

  ## Examples

      iex> create_debt(%{field: value})
      {:ok, %Debt{}}

      iex> create_debt(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_debt(attrs \\ %{}) do
    %Debt{}
    |> Debt.changeset(attrs)
    |> Repo.insert()
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

  @doc """
  Creates a payoff.

  ## Examples

      iex> create_payoff(%{field: value})
      {:ok, %Payoff{}}

      iex> create_payoff(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_payoff(attrs \\ %{}) do
    %Payoff{}
    |> Payoff.changeset(attrs)
    |> Repo.insert()
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