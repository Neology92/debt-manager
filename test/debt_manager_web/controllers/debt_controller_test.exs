defmodule DebtManagerWeb.DebtControllerTest do
  use DebtManagerWeb.ConnCase

  alias DebtManager.Flows

  @create_attrs %{amount: 120.5, date: "2010-04-17T14:00:00Z", title: "some title"}
  @update_attrs %{amount: 456.7, date: "2011-05-18T15:01:01Z", title: "some updated title"}
  @invalid_attrs %{amount: nil, date: nil, title: nil}

  def fixture(:debt) do
    {:ok, debt} = Flows.create_debt(@create_attrs)
    debt
  end

  describe "index" do
    test "lists all debts", %{conn: conn} do
      conn = get(conn, Routes.debt_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Debts"
    end
  end

  describe "new debt" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.debt_path(conn, :new))
      assert html_response(conn, 200) =~ "New Debt"
    end
  end

  describe "create debt" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.debt_path(conn, :create), debt: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.debt_path(conn, :show, id)

      conn = get(conn, Routes.debt_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Debt"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.debt_path(conn, :create), debt: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Debt"
    end
  end

  describe "edit debt" do
    setup [:create_debt]

    test "renders form for editing chosen debt", %{conn: conn, debt: debt} do
      conn = get(conn, Routes.debt_path(conn, :edit, debt))
      assert html_response(conn, 200) =~ "Edit Debt"
    end
  end

  describe "update debt" do
    setup [:create_debt]

    test "redirects when data is valid", %{conn: conn, debt: debt} do
      conn = put(conn, Routes.debt_path(conn, :update, debt), debt: @update_attrs)
      assert redirected_to(conn) == Routes.debt_path(conn, :show, debt)

      conn = get(conn, Routes.debt_path(conn, :show, debt))
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, debt: debt} do
      conn = put(conn, Routes.debt_path(conn, :update, debt), debt: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Debt"
    end
  end

  describe "delete debt" do
    setup [:create_debt]

    test "deletes chosen debt", %{conn: conn, debt: debt} do
      conn = delete(conn, Routes.debt_path(conn, :delete, debt))
      assert redirected_to(conn) == Routes.debt_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.debt_path(conn, :show, debt))
      end
    end
  end

  defp create_debt(_) do
    debt = fixture(:debt)
    %{debt: debt}
  end
end
