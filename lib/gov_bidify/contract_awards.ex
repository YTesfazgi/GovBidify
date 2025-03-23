defmodule GovBidify.ContractAwards do
  @moduledoc """
  The ContractAwards context.
  """

  import Ecto.Query, warn: false
  alias GovBidify.Repo

  alias GovBidify.ContractAwards.ContractAward

  @doc """
  Returns the list of contract_awards.

  ## Examples

      iex> list_contract_awards()
      [%ContractAward{}, ...]

  """
  def list_contract_awards do
    Repo.all(ContractAward)
  end

  @doc """
  Gets a single contract_award.

  Raises `Ecto.NoResultsError` if the Contract award does not exist.

  ## Examples

      iex> get_contract_award!(123)
      %ContractAward{}

      iex> get_contract_award!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contract_award_by_contract_transaction_unique_key!(contract_transaction_unique_key),
    do: Repo.get!(ContractAward, contract_transaction_unique_key)

  @doc """
  Creates a contract_award.

  ## Examples

      iex> create_contract_award(%{field: value})
      {:ok, %ContractAward{}}

      iex> create_contract_award(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contract_award(attrs \\ %{}) do
    %ContractAward{}
    |> ContractAward.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a contract_award.

  ## Examples

      iex> update_contract_award(contract_award, %{field: new_value})
      {:ok, %ContractAward{}}

      iex> update_contract_award(contract_award, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contract_award(%ContractAward{} = contract_award, attrs) do
    contract_award
    |> ContractAward.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a contract_award.

  ## Examples

      iex> delete_contract_award(contract_award)
      {:ok, %ContractAward{}}

      iex> delete_contract_award(contract_award)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contract_award(%ContractAward{} = contract_award) do
    Repo.delete(contract_award)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contract_award changes.

  ## Examples

      iex> change_contract_award(contract_award)
      %Ecto.Changeset{data: %ContractAward{}}

  """
  def change_contract_award(%ContractAward{} = contract_award, attrs \\ %{}) do
    ContractAward.changeset(contract_award, attrs)
  end

  @doc """
  Returns all contract awards containing the search_term in their title or description.

  ## Examples

      iex> search(search_term)
      [%ContractAward{}, ...]
  """
  def search(search_term) when is_binary(search_term) do
    query =
      from(o in ContractAward,
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
      from(o in ContractAward,
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

    # flop = Flop.nest_filters(flop, [])

    {:ok, {results, meta}} = Flop.validate_and_run(query, flop, for: ContractAward)

    {results, meta}
  end

  def get_related_contract_awards(opportunity) do
    # Collect awards in priority order
    exact_matches = get_exact_matches(opportunity)
    strong_matches = get_strong_matches(opportunity)
    moderate_matches = get_moderate_matches(opportunity)

    # Combine results in priority order, removing duplicates and limiting to 20
    combined_results =
      exact_matches ++
      Enum.filter(strong_matches, fn match -> match.contract_transaction_unique_key not in Enum.map(exact_matches, & &1.contract_transaction_unique_key) end) ++
      Enum.filter(moderate_matches, fn match ->
        match.contract_transaction_unique_key not in (
          Enum.map(exact_matches, & &1.contract_transaction_unique_key) ++
          Enum.map(strong_matches, & &1.contract_transaction_unique_key)
        )
      end)

    # Return top 20
    top_results = Enum.take(combined_results, 20)

    %{
      results: top_results,
      exact_matches: exact_matches,
      strong_matches: strong_matches,
      moderate_matches: moderate_matches
    }
  end

  # Direct identifier matches (solicitation ID or award number)
  defp get_exact_matches(opportunity) do
    # Skip if these fields are empty
    case {opportunity.sol, opportunity.award_number} do
      {"", ""} -> []
      {nil, nil} -> []
      _ ->
        query = from ca in ContractAward,
          where: (ca.solicitation_identifier == ^opportunity.sol and ^opportunity.sol != "")
                 or (ca.award_id_piid == ^opportunity.award_number and ^opportunity.award_number != ""),
          order_by: [desc: ca.action_date],
          limit: 20

        Repo.all(query)
    end
  end

  # Same agency + NAICS code
  defp get_strong_matches(opportunity) do
    query = from ca in ContractAward,
      where: (ca.awarding_agency_code == ^opportunity.cgac and ca.naics_code == ^opportunity.naics_code),
      order_by: [desc: ca.action_date],
      limit: 20

    Repo.all(query)
  end

  # Adding a new function for moderate matches (PSC code, place of performance)
  defp get_moderate_matches(opportunity) do
    query = from ca in ContractAward,
      where: (ca.product_or_service_code == ^opportunity.classification_code and ^opportunity.classification_code != "") or
             (ca.primary_place_of_performance_state_code == ^opportunity.pop_state and ^opportunity.pop_state != ""),
      order_by: [desc: ca.action_date],
      limit: 40  # Get more than needed since we'll filter some out

    Repo.all(query)
  end
end
