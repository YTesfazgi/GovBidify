defmodule GovBidify.Opportunities do
  @moduledoc """
  The Opportunities context.
  """

  import Ecto.Query, warn: false
  alias GovBidify.Opportunities.{SAMOpportunity}
  alias GovBidify.Repo

  @doc """
  Returns the list of sam_opportunities.

  ## Examples

      iex> list_sam_opportunities()
      [%SAMOpportunity{}, ...]

  """
  def list_sam_opportunities do
    Repo.all(SAMOpportunity)
  end

  @doc """
  Gets a single sam_opportunity.

  Raises `Ecto.NoResultsError` if the Sam opportunity does not exist.

  ## Examples

      iex> get_sam_opportunity!(123)
      %SAMOpportunity{}

      iex> get_sam_opportunity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sam_opportunity!(id), do: Repo.get!(SAMOpportunity, id)

  @doc """
  Creates a sam_opportunity.

  ## Examples

      iex> create_sam_opportunity(%{field: value})
      {:ok, %SAMOpportunity{}}

      iex> create_sam_opportunity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sam_opportunity(attrs \\ %{}) do
    %SAMOpportunity{}
    |> SAMOpportunity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sam_opportunity.

  ## Examples

      iex> update_sam_opportunity(sam_opportunity, %{field: new_value})
      {:ok, %SAMOpportunity{}}

      iex> update_sam_opportunity(sam_opportunity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sam_opportunity(%SAMOpportunity{} = sam_opportunity, attrs) do
    sam_opportunity
    |> SAMOpportunity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sam_opportunity.

  ## Examples

      iex> delete_sam_opportunity(sam_opportunity)
      {:ok, %SAMOpportunity{}}

      iex> delete_sam_opportunity(sam_opportunity)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sam_opportunity(%SAMOpportunity{} = sam_opportunity) do
    Repo.delete(sam_opportunity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sam_opportunity changes.

  ## Examples

      iex> change_sam_opportunity(sam_opportunity)
      %Ecto.Changeset{data: %SAMOpportunity{}}

  """
  def change_sam_opportunity(%SAMOpportunity{} = sam_opportunity, attrs \\ %{}) do
    SAMOpportunity.changeset(sam_opportunity, attrs)
  end

  @doc """
  Returns all sam_opportunities containing the search_term in their title or description.

  ## Examples

      iex> search_sam_opportunities_by_title_and_description(search_term)
      [%SAMOpportunity{}, ...]
  """
  def search_sam_opportunities_by_title_and_description(search_term) when is_binary(search_term) do
    pattern = "%#{search_term}%"

    query = from o in SAMOpportunity,
            where: ilike(o.title, ^pattern) or ilike(o.description, ^pattern),
            select: o

    Repo.all(query)
  end
end
