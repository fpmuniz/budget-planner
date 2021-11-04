defmodule BudgetPlanningWeb.SubcategoryController do
  use BudgetPlanningWeb, :controller

  alias BudgetPlanning.Transactions
  alias BudgetPlanning.Transactions.Subcategory

  def index(conn, _params) do
    subcategories = Transactions.list_subcategories([:category])
    render(conn, "index.html", subcategories: subcategories)
  end

  def new(conn, _params) do
    changeset = Transactions.change_subcategory(%Subcategory{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"subcategory" => subcategory_params}) do
    case Transactions.create_subcategory(subcategory_params) do
      {:ok, subcategory} ->
        conn
        |> put_flash(:info, "Subcategory created successfully.")
        |> redirect(to: Routes.subcategory_path(conn, :show, subcategory))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    subcategory = Transactions.get_subcategory!(id, [:category])
    render(conn, "show.html", subcategory: subcategory)
  end

  def edit(conn, %{"id" => id}) do
    subcategory = Transactions.get_subcategory!(id)
    changeset = Transactions.change_subcategory(subcategory)
    render(conn, "edit.html", subcategory: subcategory, changeset: changeset)
  end

  def update(conn, %{"id" => id, "subcategory" => subcategory_params}) do
    subcategory = Transactions.get_subcategory!(id)

    case Transactions.update_subcategory(subcategory, subcategory_params) do
      {:ok, subcategory} ->
        conn
        |> put_flash(:info, "Subcategory updated successfully.")
        |> redirect(to: Routes.subcategory_path(conn, :show, subcategory))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", subcategory: subcategory, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    subcategory = Transactions.get_subcategory!(id)
    {:ok, _subcategory} = Transactions.delete_subcategory(subcategory)

    conn
    |> put_flash(:info, "Subcategory deleted successfully.")
    |> redirect(to: Routes.subcategory_path(conn, :index))
  end
end
