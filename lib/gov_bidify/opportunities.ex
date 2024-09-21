defmodule GovBidify.Opportunities do
  @moduledoc """
  The Opportunities context.
  """

  import Ecto.Query, warn: false
  alias GovBidify.Opportunities.{Opportunity}
  alias GovBidify.Repo

  @doc """
  Returns the list of opportunities.

  ## Examples

      iex> list_opportunities()
      [%Opportunity{}, ...]

  """
  def list_opportunities do
    Repo.all(Opportunity)
  end

  def list_departments do
    Repo.all(from o in Opportunity, distinct: [:department_ind_agency])
  end

  def list_sub_tiers do
    Repo.all(from o in Opportunity, distinct: [:sub_tier])
  end

  @doc """
  Gets a single opportunity.

  Raises `Ecto.NoResultsError` if the opportunity does not exist.

  ## Examples

      iex> get_opportunity!(123)
      %Opportunity{}

      iex> get_opportunity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_opportunity_by_notice_id!(notice_id), do: Repo.get!(Opportunity, notice_id)

  @doc """
  Creates an opportunity.

  ## Examples

      iex> create_opportunity(%{field: value})
      {:ok, %Opportunity{}}

      iex> create_opportunity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_opportunity(attrs \\ %{}) do
    %Opportunity{}
    |> Opportunity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates an opportunity.

  ## Examples

      iex> update_opportunity(opportunity, %{field: new_value})
      {:ok, %Opportunity{}}

      iex> update_opportunity(opportunity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_opportunity(%Opportunity{} = opportunity, attrs) do
    opportunity
    |> Opportunity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes an opportunity.

  ## Examples

      iex> delete_opportunity(opportunity)
      {:ok, %Opportunity{}}

      iex> delete_opportunity(opportunity)
      {:error, %Ecto.Changeset{}}

  """
  def delete_opportunity(%Opportunity{} = opportunity) do
    Repo.delete(opportunity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking opportunity changes.

  ## Examples

      iex> change_opportunity(opportunity)
      %Ecto.Changeset{data: %Opportunity{}}

  """
  def change_opportunity(%Opportunity{} = opportunity, attrs \\ %{}) do
    Opportunity.changeset(opportunity, attrs)
  end

  @doc """
  Returns all opportunities containing the search_term in their title or description.

  ## Examples

      iex> search_opportunities_by_title_and_description(search_term)
      [%Opportunity{}, ...]
  """
  def search_opportunities_by_title_and_description(search_term) when is_binary(search_term) do
    pattern = "%#{search_term}%"

    query =
      from o in Opportunity,
        where: ilike(o.title, ^pattern) or ilike(o.description, ^pattern),
        select: o

    Repo.all(query)
  end

  def search_opportunities_by_title_and_description(query, flop_params) do
    flop = Flop.validate!(flop_params, for: Opportunity)

    base_query =
      from o in Opportunity,
        where: ilike(o.title, ^"%#{query}%") or ilike(o.description, ^"%#{query}%")

    {results, meta} = Flop.run(base_query, flop, for: Opportunity)

    {results, meta}
  end
end
