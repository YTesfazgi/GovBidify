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
    %{
      "ADMINISTRATIVE OFFICE OF THE US COURTS" => "Administrative Office of the US Courts",
      "AGENCY FOR INTERNATIONAL DEVELOPMENT" => "Agency for International Development",
      "AGRICULTURE, DEPARTMENT OF" => "Department of Agriculture",
      "AMERICAN BATTLE MONUMENTS COMMISSION" => "American Battle Monuments Commission",
      "ARCHITECT OF THE CAPITOL" => "Architect of the Capitol",
      "COMMERCE, DEPARTMENT OF" => "Department of Commerce",
      "COMMITTEE FOR PURCHASE FROM PEOPLE WHO ARE BLIND OR SEVERELY DISABLED" => "Committee for Purchase from People who are Blind or Severely Disabled",
      "COMMODITY FUTURES TRADING COMMISSION" => "Commodity Futures Trading Commission",
      "CONSUMER FINANCIAL PROTECTION BUREAU" => "Consumer Financial Protection Bureau",
      "CONSUMER PRODUCT SAFETY COMMISSION" => "Consumer Product Safety Commission",
      "CORPORATION FOR NATIONAL AND COMMUNITY SERVICE" => "Corporation for National and Community Service",
      "COURT SERVICES AND OFFENDER SUPERVISION AGENCY" => "Court Services and Offender Supervision Agency",
      "DEPT OF DEFENSE" => "Department of Defense",
      "DISTRICT OF COLUMBIA COURTS" => "District of Columbia Courts",
      "EDUCATION, DEPARTMENT OF" => "Department of Education",
      "ENERGY, DEPARTMENT OF" => "Department of Energy",
      "ENVIRONMENTAL PROTECTION AGENCY" => "Environmental Protection Agency",
      "EQUAL EMPLOYMENT OPPORTUNITY COMMISSION" => "Equal Employment Opportunity Commission",
      "EXECUTIVE OFFICE OF THE PRESIDENT" => "Executive Office of the President",
      "EXPORT-IMPORT BANK OF THE US" => "Export-Import Bank of the US",
      "FARM CREDIT ADMINISTRATION" => "Farm Credit Administration",
      "FEDERAL COMMUNICATIONS COMMISSION" => "Federal Communications Commission",
      "FEDERAL DEPOSIT INSURANCE CORPORATION" => "Federal Deposit Insurance Corporation",
      "FEDERAL HOUSING FINANCE AGENCY" => "Federal Housing Finance Agency",
      "FEDERAL MARITIME COMMISSION" => "Federal Maritime Commission",
      "FEDERAL MEDIATION AND CONCILIATION SERVICE" => "Federal Mediation and Conciliation Service",
      "FEDERAL RETIREMENT THRIFT INVESTMENT BOARD" => "Federal Retirement Thrift Investment Board",
      "FEDERAL TRADE COMMISSION" => "Federal Trade Commission",
      "GENERAL SERVICES ADMINISTRATION" => "General Services Administration",
      "GOVERNMENT ACCOUNTABILITY OFFICE" => "Government Accountability Office",
      "HEALTH AND HUMAN SERVICES, DEPARTMENT OF" => "Department of Health and Human Services",
      "HOMELAND SECURITY, DEPARTMENT OF" => "Department of Homeland Security",
      "HOUSE OF REPRESENTATIVES, THE" => "The House of Representatives",
      "HOUSING AND URBAN DEVELOPMENT, DEPARTMENT OF" => "Department of Housing and Urban Development",
      "INTERIOR, DEPARTMENT OF THE" => "Department of the Interior",
      "INTERNATIONAL BOUNDARY AND WATER COMMISSION: US-MEXICO" => "International Boundary and Water Commission: US-Mexico",
      "INTERNATIONAL TRADE COMMISSION, UNITED STATES (DUNS # 02-1877998)" => "United States International Trade Commission",
      "J F KENNEDY CENTER FOR THE PERFORMING ARTS" => "John F. Kennedy Center for the Performing Arts",
      "JUSTICE, DEPARTMENT OF" => "Department of Justice",
      "LABOR, DEPARTMENT OF" => "Department of Labor",
      "LEGAL SERVICES CORPORATION" => "Legal Services Corporation",
      "LIBRARY OF CONGRESS" => "Library of Congress",
      "MERIT SYSTEMS PROTECTION BOARD" => "Merit Systems Protection Board",
      "MILLENNIUM CHALLENGE CORPORATION" => "Millennium Challenge Corporation",
      "MORRIS K UDALL SCHOLARSHIP AND EXCELLENCE IN NATIONAL ENVIRONMENTAL POLICY FOUNDATION" => "Morris K. Udall Scholarship and Excellence in National Environmental Policy Foundation",
      "NATIONAL AERONAUTICS AND SPACE ADMINISTRATION" => "National Aeronautics and Space Administration",
      "NATIONAL ARCHIVES AND RECORDS ADMINISTRATION" => "National Archives and Records Administration",
      "NATIONAL CAPITAL PLANNING COMMISSION" => "National Capital Planning Commission",
      "NATIONAL ENDOWMENT FOR THE HUMANITIES" => "National Endowment for the Humanities",
      "NATIONAL GALLERY OF ART" => "National Gallery of Art",
      "NATIONAL SCIENCE FOUNDATION" => "National Science Foundation",
      "NATIONAL TRANSPORTATION SAFETY BOARD" => "National Transportation Safety Board",
      "NUCLEAR REGULATORY COMMISSION" => "Nuclear Regulatory Commission",
      "OFFICE OF PERSONNEL MANAGEMENT" => "Office of Personnel Management",
      "OFFICE OF THE DIRECTOR OF NATIONAL INTELLIGENCE" => "Office of the Director of National Intelligence",
      "OPEN WORLD LEADERSHIP CENTER" => "Open World Leadership Center",
      "PEACE CORPS" => "Peace Corps",
      "PENSION BENEFIT GUARANTY CORPORATION" => "Pension Benefit Guaranty Corporation",
      "POSTAL SERVICE" => "Postal Service",
      "RAILROAD RETIREMENT BOARD" => "Railroad Retirement Board",
      "SECURITIES AND EXCHANGE COMMISSION" => "Securities and Exchange Commission",
      "SENATE, THE" => "The Senate",
      "SMALL BUSINESS ADMINISTRATION" => "Small Business Administration",
      "SMITHSONIAN INSTITUTION" => "Smithsonian Institution",
      "SOCIAL SECURITY ADMINISTRATION" => "Social Security Administration",
      "STATE, DEPARTMENT OF" => "Department of State",
      "THE COUNCIL OF THE INSPECTORS GENERAL ON INTEGRITY AND EFFICIENCY" => "The Council of the Inspectors General on Integrity and Efficiency",
      "THE LEGISLATIVE BRANCH" => "The Legislative Branch",
      "TRANSPORTATION, DEPARTMENT OF" => "Department of Transportation",
      "TREASURY, DEPARTMENT OF THE" => "Department of the Treasury",
      "UNITED STATES AGENCY FOR GLOBAL MEDIA, BBG" => "United States Agency for Global Media",
      "UNITED STATES GOVERNMENT PUBLISHING OFFICE" => "United States Government Publishing Office",
      "UNITED STATES HOLOCAUST MEMORIAL MUSEUM" => "United States Holocaust Memorial Museum",
      "UNITED STATES INTERNATIONAL DEVELOPMENT FINANCE CORPORATION" => "United States International Development Finance Corporation",
      "UNITED STATES TRADE AND DEVELOPMENT AGENCY" => "United States Trade and Development Agency",
      "VETERANS AFFAIRS, DEPARTMENT OF" => "Department of Veterans Affairs"
    }
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

  def list_set_asides do
    Repo.all(from o in Opportunity, distinct: [:set_aside], select: o.set_aside)
    |> Enum.reject(&(&1 == "" or is_nil(&1)))
    |> Enum.sort()
  end

  def list_naics_codes do
    Repo.all(from o in Opportunity, distinct: [:naics_code], select: o.naics_code)
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

    flop = Flop.nest_filters(flop, [:type, :department_ind_agency, :sub_tier, :office, :set_aside, :naics_code, :pop_country, :pop_state, :active], operators: %{type: :in, department_ind_agency: :in, sub_tier: :in, office: :in, set_aside: :in, naics_code: :in, pop_country: :in, pop_state: :in, active: :in})

    {:ok, {results, meta}} = Flop.validate_and_run(query, flop, for: Opportunity)

    {results, meta}
  end
end
