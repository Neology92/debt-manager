defmodule DebtManagerWeb.PayoffControllerTest do
  use DebtManagerWeb.ConnCase

  alias DebtManager.Flows

  @create_attrs %{amount: 120.5, date: "2010-04-17T14:00:00Z", title: "some title"}
  @update_attrs %{amount: 456.7, date: "2011-05-18T15:01:01Z", title: "some updated title"}
  @invalid_attrs %{amount: nil, date: nil, title: nil}

  def fixture(:payoff) do
    {:ok, payoff} = Flows.create_payoff(@create_attrs)
    payoff
  end

  describe "index" do
    test "lists all payoffs", %{conn: conn} do
      conn = get(conn, Routes.payoff_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Payoffs"
    end
  end

  describe "new payoff" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.payoff_path(conn, :new))
      assert html_response(conn, 200) =~ "New Payoff"
    end
  end

  describe "create payoff" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.payoff_path(conn, :create), payoff: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.payoff_path(conn, :show, id)

      conn = get(conn, Routes.payoff_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Payoff"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.payoff_path(conn, :create), payoff: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Payoff"
    end
  end

  describe "edit payoff" do
    setup [:create_payoff]

    test "renders form for editing chosen payoff", %{conn: conn, payoff: payoff} do
      conn = get(conn, Routes.payoff_path(conn, :edit, payoff))
      assert html_response(conn, 200) =~ "Edit Payoff"
    end
  end

  describe "update payoff" do
    setup [:create_payoff]

    test "redirects when data is valid", %{conn: conn, payoff: payoff} do
      conn = put(conn, Routes.payoff_path(conn, :update, payoff), payoff: @update_attrs)
      assert redirected_to(conn) == Routes.payoff_path(conn, :show, payoff)

      conn = get(conn, Routes.payoff_path(conn, :show, payoff))
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, payoff: payoff} do
      conn = put(conn, Routes.payoff_path(conn, :update, payoff), payoff: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Payoff"
    end
  end

  describe "delete payoff" do
    setup [:create_payoff]

    test "deletes chosen payoff", %{conn: conn, payoff: payoff} do
      conn = delete(conn, Routes.payoff_path(conn, :delete, payoff))
      assert redirected_to(conn) == Routes.payoff_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.payoff_path(conn, :show, payoff))
      end
    end
  end

  defp create_payoff(_) do
    payoff = fixture(:payoff)
    %{payoff: payoff}
  end
end
