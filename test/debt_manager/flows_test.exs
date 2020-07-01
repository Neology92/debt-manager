defmodule DebtManager.FlowsTest do
  use DebtManager.DataCase

  alias DebtManager.Flows

  describe "debts" do
    alias DebtManager.Flows.Debt

    @valid_attrs %{amount: 120.5, date: "2010-04-17T14:00:00Z", title: "some title"}
    @update_attrs %{amount: 456.7, date: "2011-05-18T15:01:01Z", title: "some updated title"}
    @invalid_attrs %{amount: nil, date: nil, title: nil}

    def debt_fixture(attrs \\ %{}) do
      {:ok, debt} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Flows.create_debt()

      debt
    end

    test "list_debts/0 returns all debts" do
      debt = debt_fixture()
      assert Flows.list_debts() == [debt]
    end

    test "get_debt!/1 returns the debt with given id" do
      debt = debt_fixture()
      assert Flows.get_debt!(debt.id) == debt
    end

    test "create_debt/1 with valid data creates a debt" do
      assert {:ok, %Debt{} = debt} = Flows.create_debt(@valid_attrs)
      assert debt.amount == 120.5
      assert debt.date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert debt.title == "some title"
    end

    test "create_debt/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flows.create_debt(@invalid_attrs)
    end

    test "update_debt/2 with valid data updates the debt" do
      debt = debt_fixture()
      assert {:ok, %Debt{} = debt} = Flows.update_debt(debt, @update_attrs)
      assert debt.amount == 456.7
      assert debt.date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert debt.title == "some updated title"
    end

    test "update_debt/2 with invalid data returns error changeset" do
      debt = debt_fixture()
      assert {:error, %Ecto.Changeset{}} = Flows.update_debt(debt, @invalid_attrs)
      assert debt == Flows.get_debt!(debt.id)
    end

    test "delete_debt/1 deletes the debt" do
      debt = debt_fixture()
      assert {:ok, %Debt{}} = Flows.delete_debt(debt)
      assert_raise Ecto.NoResultsError, fn -> Flows.get_debt!(debt.id) end
    end

    test "change_debt/1 returns a debt changeset" do
      debt = debt_fixture()
      assert %Ecto.Changeset{} = Flows.change_debt(debt)
    end
  end

  describe "payoffs" do
    alias DebtManager.Flows.Payoff

    @valid_attrs %{amount: 120.5, date: "2010-04-17T14:00:00Z", title: "some title"}
    @update_attrs %{amount: 456.7, date: "2011-05-18T15:01:01Z", title: "some updated title"}
    @invalid_attrs %{amount: nil, date: nil, title: nil}

    def payoff_fixture(attrs \\ %{}) do
      {:ok, payoff} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Flows.create_payoff()

      payoff
    end

    test "list_payoffs/0 returns all payoffs" do
      payoff = payoff_fixture()
      assert Flows.list_payoffs() == [payoff]
    end

    test "get_payoff!/1 returns the payoff with given id" do
      payoff = payoff_fixture()
      assert Flows.get_payoff!(payoff.id) == payoff
    end

    test "create_payoff/1 with valid data creates a payoff" do
      assert {:ok, %Payoff{} = payoff} = Flows.create_payoff(@valid_attrs)
      assert payoff.amount == 120.5
      assert payoff.date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert payoff.title == "some title"
    end

    test "create_payoff/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flows.create_payoff(@invalid_attrs)
    end

    test "update_payoff/2 with valid data updates the payoff" do
      payoff = payoff_fixture()
      assert {:ok, %Payoff{} = payoff} = Flows.update_payoff(payoff, @update_attrs)
      assert payoff.amount == 456.7
      assert payoff.date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert payoff.title == "some updated title"
    end

    test "update_payoff/2 with invalid data returns error changeset" do
      payoff = payoff_fixture()
      assert {:error, %Ecto.Changeset{}} = Flows.update_payoff(payoff, @invalid_attrs)
      assert payoff == Flows.get_payoff!(payoff.id)
    end

    test "delete_payoff/1 deletes the payoff" do
      payoff = payoff_fixture()
      assert {:ok, %Payoff{}} = Flows.delete_payoff(payoff)
      assert_raise Ecto.NoResultsError, fn -> Flows.get_payoff!(payoff.id) end
    end

    test "change_payoff/1 returns a payoff changeset" do
      payoff = payoff_fixture()
      assert %Ecto.Changeset{} = Flows.change_payoff(payoff)
    end
  end
end
