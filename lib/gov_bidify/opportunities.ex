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

  def list_types do
    Repo.all(from o in Opportunity, distinct: [:type], select: o.type)
    |> Enum.reject(&(&1 == "" or is_nil(&1)))
    |> Enum.sort()
  end

  def list_departments do
    Repo.all(from o in Opportunity, distinct: [:department_ind_agency], select: o.department_ind_agency)
    |> Enum.reject(&(&1 == "" or is_nil(&1)))
    |> Enum.sort()
  end

  def list_sub_tiers do
    Repo.all(from o in Opportunity, distinct: [:sub_tier], select: o.sub_tier)
    |> Enum.reject(&(&1 == "" or is_nil(&1)))
    |> Enum.sort()
  end

  def list_offices do
    Repo.all(from o in Opportunity, distinct: [:office], select: o.office)
    |> Enum.reject(&(&1 == "" or is_nil(&1)))
    |> Enum.sort()
  end

  def list_countries do
    Repo.all(from o in Opportunity, distinct: [:pop_country], select: o.pop_country)
    |> Enum.reject(&(&1 == "" or is_nil(&1)))
    |> Enum.sort()
  end

  def list_states do
    Repo.all(from o in Opportunity, distinct: [:pop_state], select: o.pop_state)
    |> Enum.reject(&(&1 == "" or is_nil(&1)))
    |> Enum.sort()
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
    # Remove any empty list filters
    cleaned_filters = Enum.reduce(flop.filters, %{}, fn {key, value}, acc ->
      case value do
        [] -> acc
        val -> Map.put(acc, key, val)
      end
    end)

    filters = Flop.map_to_filter_params(cleaned_filters, operators: %{type: :in, department_ind_agency: :in, sub_tier: :in, office: :in, pop_country: :in, pop_state: :in, pop_city: :in, active: :in})
    flop = Map.put(flop, :filters, filters)
    flop = Flop.validate!(flop, for: Opportunity)

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

    {results, meta} = Flop.run(query, flop, for: Opportunity)

    {results, meta}
  end
end
