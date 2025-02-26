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
end
