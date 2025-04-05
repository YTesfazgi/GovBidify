defmodule GovBidify.Opportunities do
  @moduledoc """
  The Opportunities context.
  """

  import Ecto.Query, warn: false
  alias GovBidify.Opportunities.{Opportunity}
  alias GovBidify.Repo
  alias GovBidify.StaticData

  @doc """
  Returns the list of opportunities.

  ## Examples

      iex> list_opportunities()
      [%Opportunity{}, ...]

  """
  def list_opportunities do
    Repo.all(Opportunity)
  end

  def list_types do
    StaticData.list_types()
  end

  def list_departments do
    StaticData.list_departments()
  end

  def list_sub_tiers do
    StaticData.list_sub_tiers()
  end

  def list_offices do
    StaticData.list_offices()
  end

  @doc """
  Updates the offices static data file with current data from the database.
  This should be called periodically, such as after data imports.
  """
  def update_offices_static_data do
    offices = Repo.all(from o in Opportunity, distinct: [:office], select: o.office)
              |> Enum.reject(&(&1 == "" or is_nil(&1)))
              |> Enum.sort()

    StaticData.update_offices(offices)
  end

  def list_set_asides do
    StaticData.list_set_asides()
  end

  @doc """
  Updates the set_asides static data file with current data from the database.
  This should be called periodically, such as after data imports.
  """
  def update_set_asides_static_data do
    set_asides = Repo.all(from o in Opportunity, distinct: [:set_aside], select: o.set_aside)
                 |> Enum.reject(&(&1 == "" or is_nil(&1)))
                 |> Enum.sort()

    StaticData.update_set_asides(set_asides)
  end

  def list_countries do
    StaticData.list_countries()
  end

  def list_states do
    StaticData.list_states()
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

      iex> search(search_term)
      [%Opportunity{}, ...]
  """
  def search(search_term) when is_binary(search_term) do
    query =
      from(o in Opportunity,
        where:
          fragment(
            "searchable @@ websearch_to_tsquery(?)",
            ^search_term
          ),
        order_by: {
          :desc,
          fragment(
            "ts_rank_cd(searchable, websearch_to_tsquery(?), 4)",
            ^search_term
          )
        }
      )

    Repo.all(query)
  end

  def search(search_term, flop) do
    query =
      from(o in Opportunity,
        where:
          fragment(
            "searchable @@ websearch_to_tsquery(?)",
            ^search_term
          ),
        order_by: {
          :desc,
          fragment(
            "ts_rank_cd(searchable, websearch_to_tsquery(?), 4)",
            ^search_term
          )
        }
      )

    flop = Flop.nest_filters(flop, [:type, :department_ind_agency, :sub_tier, :office, :set_aside, :naics_code, :psc_code, :pop_country, :pop_city, :pop_state, :pop_zip, :active], operators: %{type: :in, department_ind_agency: :in, sub_tier: :in, office: :in, set_aside: :in, naics_code: :in, psc_code: :in, pop_country: :in, pop_city: :in, pop_state: :in, pop_zip: :in, active: :in})

    {:ok, {results, meta}} = Flop.validate_and_run(query, flop, for: Opportunity)

    {results, meta}
  end
end
