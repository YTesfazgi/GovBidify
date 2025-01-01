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
    [
      "Award Notice", "Combined Synopsis/Solicitation", "Consolidate/(Substantially) Bundle", "Justification",
      "Presolicitation", "Sale of Surplus Property", "Solicitation", "Sources Sought", "Special Notice"
    ]
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
    %{
      "ADMINISTRATION FOR CHILDREN AND FAMILIES" => "Administration for Children and Families",
      "ADMINISTRATION FOR STRATEGIC PREPAREDNESS AND RESPONSE" => "Administration for Strategic Preparedness and Response",
      "ADMINISTRATIVE OFFICE OF THE US COURTS" => "Administrative Office of the US Courts",
      "AGENCY FOR HEALTHCARE RESEARCH AND QUALITY" => "Agency for Healthcare Research and Quality",
      "AGENCY FOR INTERNATIONAL DEVELOPMENT" => "Agency for International Development",
      "AGRICULTURAL MARKETING SERVICE" => "Agricultural Marketing Service",
      "AGRICULTURAL RESEARCH SERVICE" => "Agricultural Research Service",
      "AMERICAN BATTLE MONUMENTS COMMISSION" => "American Battle Monuments Commission",
      "ANIMAL AND PLANT HEALTH INSPECTION SERVICE" => "Animal and Plant Health Inspection Service",
      "ARCHITECT OF THE CAPITOL" => "Architect of the Capitol",
      "ARMY/AIR FORCE EXCHANGE SERVICE" => "Army/Air Force Exchange Service",
      "ATF ACQUISITION AND PROPERTY MGMT DIV" => "ATF Acquisition and Property Management Division",
      "BUREAU OF ENGRAVING AND PRINTING" => "Bureau of Engraving and Printing",
      "BUREAU OF INDIAN AFFAIRS" => "Bureau of Indian Affairs",
      "BUREAU OF INDUSTRY AND SECURITY" => "Bureau of Industry and Security",
      "BUREAU OF LAND MANAGEMENT" => "Bureau of Land Management",
      "BUREAU OF OCEAN ENERGY MANAGEMENT" => "Bureau of Ocean Energy Management",
      "BUREAU OF RECLAMATION" => "Bureau of Reclamation",
      "BUREAU OF SAFETY AND ENVIRONMENTAL ENFORCEMENT" => "Bureau of Safety and Environmental Enforcement",
      "BUREAU OF THE FISCAL SERVICE" => "Bureau of the Fiscal Service",
      "CENTERS FOR DISEASE CONTROL AND PREVENTION" => "Centers for Disease Control and Prevention",
      "CENTERS FOR MEDICARE AND MEDICAID SERVICES" => "Centers for Medicare and Medicaid Services",
      "COMMITTEE FOR PURCHASE FROM PEOPLE WHO ARE BLIND OR SEVERELY DISABLED" => "Committee for Purchase from People who are Blind or Severely Disabled",
      "COMMODITY FUTURES TRADING COMMISSION" => "Commodity Futures Trading Commission",
      "CONSUMER FINANCIAL PROTECTION BUREAU" => "Consumer Financial Protection Bureau",
      "CONSUMER PRODUCT SAFETY COMMISSION" => "Consumer Product Safety Commission",
      "CORPORATION FOR NATIONAL AND COMMUNITY SERVICE" => "Corporation for National and Community Service",
      "COURT SERVICES AND OFFENDER SUPERVISION AGENCY" => "Court Services and Offender Supervision Agency",
      "DEFENSE ADVANCED RESEARCH PROJECTS AGENCY  (DARPA)" => "Defense Advanced Research Projects Agency",
      "DEFENSE COMMISSARY AGENCY  (DECA)" => "Defense Commissary Agency",
      "DEFENSE CONTRACT MANAGEMENT AGENCY (DCMA)" => "Defense Contract Management Agency",
      "DEFENSE COUNTERINTELLIGENCE AND SECURITY AGENCY" => "Defense Counterintelligence and Security Agency",
      "DEFENSE FINANCE AND ACCOUNTING SERVICE (DFAS)" => "Defense Finance and Accounting Service",
      "DEFENSE HEALTH AGENCY (DHA)" => "Defense Health Agency",
      "DEFENSE HUMAN RESOURCES ACTIVITY" => "Defense Human Resources Activity",
      "DEFENSE INFORMATION SYSTEMS AGENCY (DISA)" => "Defense Information Systems Agency",
      "DEFENSE INTELLIGENCE AGENCY" => "Defense Intelligence Agency",
      "DEFENSE LOGISTICS AGENCY" => "Defense Logistics Agency",
      "DEFENSE MEDIA ACTIVITY (DMA)" => "Defense Media Activity",
      "DEFENSE MICROELECTRONICS ACTIVITY (DMEA)" => "Defense Microelectronics Activity",
      "DEFENSE THREAT REDUCTION AGENCY (DTRA)" => "Defense Threat Reduction Agency",
      "DEPARTMENTAL OFFICES" => "Departmental Offices",
      "DEPT OF DEFENSE EDUCATION ACTIVITY (DODEA)" => "Department of Defense Education Activity",
      "DEPT OF THE AIR FORCE" => "Department of the Air Force",
      "DEPT OF THE ARMY" => "Department of the Army",
      "DEPT OF THE NAVY" => "Department of the Navy",
      "DISTRICT OF COLUMBIA COURTS" => "District of Columbia Courts",
      "DRUG ENFORCEMENT ADMINISTRATION" => "Drug Enforcement Administration",
      "EDUCATION, DEPARTMENT OF" => "Department of Education",
      "EMPLOYMENT AND TRAINING ADMINISTRATION" => "Employment and Training Administration",
      "ENERGY, DEPARTMENT OF" => "Department of Energy",
      "ENVIRONMENTAL PROTECTION AGENCY" => "Environmental Protection Agency",
      "EQUAL EMPLOYMENT OPPORTUNITY COMMISSION" => "Equal Employment Opportunity Commission",
      "EXECUTIVE OFFICE OF THE PRESIDENT" => "Executive Office of the President",
      "EXPORT-IMPORT BANK OF THE US" => "Export-Import Bank of the US",
      "FARM CREDIT SYSTEMS INSURANCE CORPORATION" => "Farm Credit Systems Insurance Corporation",
      "FARM PRODUCTION AND CONSERVATION BUSINESS CENTER" => "Farm Production and Conservation Business Center",
      "FEDERAL ACQUISITION SERVICE" => "Federal Acquisition Service",
      "FEDERAL AVIATION ADMINISTRATION" => "Federal Aviation Administration",
      "FEDERAL BUREAU OF INVESTIGATION" => "Federal Bureau of Investigation",
      "FEDERAL COMMUNICATIONS COMMISSION" => "Federal Communications Commission",
      "FEDERAL DEPOSIT INSURANCE CORPORATION" => "Federal Deposit Insurance Corporation",
      "FEDERAL EMERGENCY MANAGEMENT AGENCY" => "Federal Emergency Management Agency",
      "FEDERAL ENERGY REGULATORY COMMISSION" => "Federal Energy Regulatory Commission",
      "FEDERAL HIGHWAY ADMINISTRATION" => "Federal Highway Administration",
      "FEDERAL HOUSING FINANCE AGENCY" => "Federal Housing Finance Agency",
      "FEDERAL LAW ENFORCEMENT TRAINING CENTER" => "Federal Law Enforcement Training Center",
      "FEDERAL MARITIME COMMISSION" => "Federal Maritime Commission",
      "FEDERAL MEDIATION AND CONCILIATION SERVICE" => "Federal Mediation and Conciliation Service",
      "FEDERAL MOTOR CARRIER SAFETY ADMINISTRATION" => "Federal Motor Carrier Safety Administration",
      "FEDERAL PRISON INDUSTRIES, INC" => "Federal Prison Industries, Inc",
      "FEDERAL PRISON SYSTEM / BUREAU OF PRISONS" => "Federal Prison System / Bureau of Prisons",
      "FEDERAL RAILROAD ADMINISTRATION" => "Federal Railroad Administration",
      "FEDERAL RETIREMENT THRIFT INVESTMENT BOARD" => "Federal Retirement Thrift Investment Board",
      "FEDERAL TRADE COMMISSION" => "Federal Trade Commission",
      "FEDERAL TRANSIT ADMINISTRATION" => "Federal Transit Administration",
      "FOOD AND DRUG ADMINISTRATION" => "Food and Drug Administration",
      "FOOD AND NUTRITION SERVICE" => "Food and Nutrition Service",
      "FOOD SAFETY AND INSPECTION SERVICE" => "Food Safety and Inspection Service",
      "FOREST SERVICE" => "Forest Service",
      "GAO, EXCEPT COMPTROLLER GENERAL" => "GAO, except Comptroller General",
      "GENERAL SERVICES ADMINISTRATION" => "General Services Administration",
      "GREAT LAKES ST LAWRENCE SEAWAY DEVELOPMENT CORPORATION" => "Great Lakes St. Lawrence Seaway Development Corporation",
      "HEALTH AND HUMAN SERVICES, DEPARTMENT OF" => "Department of Health and Human Services",
      "HEALTH RESOURCES AND SERVICES ADMINISTRATION" => "Health Resources and Services Administration",
      "HOUSING AND URBAN DEVELOPMENT, DEPARTMENT OF" => "Department of Housing and Urban Development",
      "IMMED OFFICE OF THE SECRETARY OF HEALTH AND HUMAN SERVICES" => "Immediate Office of the Secretary of Health and Human Services",
      "IMMEDIATE OFFICE OF THE SECRETARY OF DEFENSE" => "Immediate Office of the Secretary of Defense",
      "INDIAN HEALTH SERVICE" => "Indian Health Service",
      "INSPECTOR GENERAL" => "Inspector General",
      "INTELLIGENCE ADVANCED RESEARCH PROJECTS ACTIVITY" => "Intelligence Advanced Research Projects Activity",
      "INTERIOR, DEPARTMENT OF THE" => "Department of the Interior",
      "INTERNAL REVENUE SERVICE" => "Internal Revenue Service",
      "INTERNATIONAL BOUNDARY AND WATER COMMISSION: US-MEXICO" => "International Boundary and Water Commission: US-Mexico",
      "INTERNATIONAL TRADE COMMISSION" => "United States International Trade Commission",
      "J F KENNEDY CENTER FOR THE PERFORMING ARTS" => "John F. Kennedy Center for the Performing Arts",
      "JOINT HOUSE AND SENATE ENTITIES" => "Joint House and Senate Entities",
      "LIBRARY OF CONGRESS" => "Library of Congress",
      "MARITIME ADMINISTRATION" => "Maritime Administration",
      "MERIT SYSTEMS PROTECTION BOARD" => "Merit Systems Protection Board",
      "MILLENNIUM CHALLENGE CORPORATION" => "Millennium Challenge Corporation",
      "MISSILE DEFENSE AGENCY (MDA)" => "Missile Defense Agency",
      "MORRIS K UDALL SCHOLARSHIP AND EXCELLENCE IN NATIONAL ENVIRONMENTAL POLICY FOUNDATION" => "Morris K. Udall Scholarship and Excellence in National Environmental Policy Foundation",
      "NATIONAL AERONAUTICS AND SPACE ADMINISTRATION" => "National Aeronautics and Space Administration",
      "NATIONAL ARCHIVES AND RECORDS ADMINISTRATION" => "National Archives and Records Administration",
      "NATIONAL CAPITAL PLANNING COMMISSION" => "National Capital Planning Commission",
      "NATIONAL ENDOWMENT FOR THE HUMANITIES" => "National Endowment for the Humanities",
      "NATIONAL GALLERY OF ART" => "National Gallery of Art",
      "NATIONAL GEOSPATIAL-INTELLIGENCE AGENCY (NGA)" => "National Geospatial-Intelligence Agency",
      "NATIONAL HIGHWAY TRAFFIC SAFETY ADMINISTRATION" => "National Highway Traffic Safety Administration",
      "NATIONAL INSTITUTE OF STANDARDS AND TECHNOLOGY" => "National Institute of Standards and Technology",
      "NATIONAL INSTITUTES OF HEALTH" => "National Institutes of Health",
      "NATIONAL OCEANIC AND ATMOSPHERIC ADMINISTRATION" => "National Oceanic and Atmospheric Administration",
      "NATIONAL PARK SERVICE" => "National Park Service",
      "NATIONAL RECONNAISSANCE OFFICE (NRO)" => "National Reconnaissance Office",
      "NATIONAL SCIENCE FOUNDATION" => "National Science Foundation",
      "NATIONAL TELECOMMUNICATIONS AND INFORMATION ADMINISTRATION" => "National Telecommunications and Information Administration",
      "NATIONAL TRANSPORTATION SAFETY BOARD" => "National Transportation Safety Board",
      "NUCLEAR REGULATORY COMMISSION" => "Nuclear Regulatory Commission",
      "OFFICE OF ADMINISTRATIVE SERVICES" => "Office of Administrative Services",
      "OFFICE OF ASSISTANT SECRETARY FOR PREPAREDNESS AND RESPONSE" => "Office of Assistant Secretary for Preparedness and Response",
      "OFFICE OF INSPECTOR GENERAL" => "Office of Inspector General",
      "OFFICE OF JUSTICE PROGRAMS" => "Office of Justice Programs",
      "OFFICE OF PERSONNEL MANAGEMENT" => "Office of Personnel Management",
      "OFFICE OF PROCUREMENT OPERATIONS" => "Office of Procurement Operations",
      "OFFICE OF SMALL AND DISADVANTAGED BUSINESS UTILIZATION" => "Office of Small and Disadvantaged Business Utilization",
      "OFFICE OF SMALL BUSINESS UTILIZATION" => "Office of Small Business Utilization",
      "OFFICE OF SURFACE MINING, RECLAMATION AND ENFORCEMENT" => "Office of Surface Mining, Reclamation and Enforcement",
      "OFFICE OF THE ASSISTANT SECRETARY FOR ADMINISTRATION (ASA)" => "Office of the Assistant Secretary for Administration",
      "OFFICE OF THE ASSISTANT SECRETARY FOR ADMINISTRATION AND MANAGEMENT" => "Office of the Assistant Secretary for Administration and Management",
      "OFFICE OF THE ASSISTANT SECRETARY FOR FINANCIAL RESOURCES (ASFR)" => "Office of the Assistant Secretary for Financial Resources",
      "OFFICE OF THE CHIEF PROCUREMENT OFFICER" => "Office of the Chief Procurement Officer",
      "OFFICE OF THE COMPTROLLER OF THE CURRENCY" => "Office of the Comptroller of the Currency",
      "OFFICE OF THE INSPECTOR GENERAL" => "Office of the Inspector General",
      "OFFICE OF THE SECRETARY" => "Office of the Secretary",
      "OFFICES, BOARDS AND DIVISIONS" => "Offices, Boards and Divisions",
      "OPEN WORLD LEADERSHIP CENTER" => "Open World Leadership Center",
      "PEACE CORPS" => "Peace Corps",
      "PENSION BENEFIT GUARANTY CORPORATION" => "Pension Benefit Guaranty Corporation",
      "PIPELINE AND HAZARDOUS MATERIALS SAFETY ADMINISTRATION" => "Pipeline and Hazardous Materials Safety Administration",
      "POSTAL SERVICE" => "Postal Service",
      "PRETRIAL SERVICES AGENCY" => "Pre-Trial Services Agency",
      "PUBLIC BUILDINGS SERVICE" => "Public Buildings Service",
      "RAILROAD RETIREMENT BOARD" => "Railroad Retirement Board",
      "RURAL HOUSING SERVICE" => "Rural Housing Service",
      "SECURITIES AND EXCHANGE COMMISSION" => "Securities and Exchange Commission",
      "SMALL BUSINESS ADMINISTRATION" => "Small Business Administration",
      "SMITHSONIAN INSTITUTION" => "Smithsonian Institution",
      "SOCIAL SECURITY ADMINISTRATION" => "Social Security Administration",
      "STATE, DEPARTMENT OF" => "Department of State",
      "SUBSTANCE ABUSE AND MENTAL HEALTH SERVICES ADMINISTRATION" => "Substance Abuse and Mental Health Services Administration",
      "THE UNITED STATES SENATE SERGEANT AT ARMS" => "United States Senate Sergeant at Arms",
      "TRANSPORTATION SECURITY ADMINISTRATION" => "Transportation Security Administration",
      "UNIFORMED SERVICES UNIVERSITY OF THE HEALTH SCIENCES  (USUHS)" => "Uniformed Services University of the Health Sciences",
      "UNITED STATES AGENCY FOR GLOBAL MEDIA, BBG" => "United States Agency for Global Media",
      "UNITED STATES GOVERNMENT PUBLISHING OFFICE" => "United States Government Publishing Office",
      "UNITED STATES HOLOCAUST MEMORIAL MUSEUM" => "United States Holocaust Memorial Museum",
      "UNITED STATES INTERNATIONAL DEVELOPMENT FINANCE CORPORATION" => "United States International Development Finance Corporation",
      "UNITED STATES MINT" => "United States Mint",
      "UNITED STATES TRADE AND DEVELOPMENT AGENCY" => "United States Trade and Development Agency",
      "US CENSUS BUREAU" => "United States Census Bureau",
      "US CITIZENSHIP AND IMMIGRATION SERVICES" => "United States Citizenship and Immigration Services",
      "US COAST GUARD" => "United States Coast Guard",
      "US CUSTOMS AND BORDER PROTECTION" => "United States Customs and Border Protection",
      "US FISH AND WILDLIFE SERVICE" => "United States Fish and Wildlife Service",
      "US GEOLOGICAL SURVEY" => "United States Geological Survey",
      "US IMMIGRATION AND CUSTOMS ENFORCEMENT" => "United States Immigration and Customs Enforcement",
      "US MARSHALS SERVICE" => "United States Marshals Service",
      "US PATENT AND TRADEMARK OFFICE" => "United States Patent and Trademark Office",
      "US SECRET SERVICE" => "United States Secret Service",
      "US SPECIAL OPERATIONS COMMAND (USSOCOM)" => "United States Special Operations Command",
      "US TRANSPORTATION COMMAND (USTRANSCOM)" => "United States Transportation Command",
      "USDA, DEPARTMENTAL ADMINISTRATION" => "Departmental Administration",
      "VETERANS AFFAIRS, DEPARTMENT OF" => "Department of Veterans Affairs",
      "WASHINGTON HEADQUARTERS SERVICES (WHS)" => "Washington Headquarters Services"
    }
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
    %{
      "AFG" => "Afghanistan",
      "AGO" => "Angola",
      "ALB" => "Albania",
      "ARE" => "United Arab Emirates",
      "ARG" => "Argentina",
      "ARM" => "Armenia",
      "ATA" => "Antarctica",
      "AUS" => "Australia",
      "AUT" => "Austria",
      "AX1" => "Åland Islands",
      "AX2" => "Åland Islands",
      "AZE" => "Azerbaijan",
      "BDI" => "Burundi",
      "BEL" => "Belgium",
      "BEN" => "Benin",
      "BFA" => "Burkina Faso",
      "BGD" => "Bangladesh",
      "BGR" => "Bulgaria",
      "BHR" => "Bahrain",
      "BHS" => "Bahamas",
      "BIH" => "Bosnia and Herzegovina",
      "BLR" => "Belarus",
      "BLZ" => "Belize",
      "BOL" => "Bolivia",
      "BRA" => "Brazil",
      "BRB" => "Barbados",
      "BWA" => "Botswana",
      "CAF" => "Central African Republic",
      "CAN" => "Canada",
      "CHE" => "Switzerland",
      "CHL" => "Chile",
      "CHN" => "China",
      "CIV" => "Côte d'Ivoire",
      "CMR" => "Cameroon",
      "COD" => "Congo, Democratic Republic",
      "COG" => "Congo, Republic",
      "COK" => "Cook Islands",
      "COL" => "Colombia",
      "CPV" => "Cape Verde",
      "CRI" => "Costa Rica",
      "CUB" => "Cuba",
      "CUW" => "Curaçao",
      "CYP" => "Cyprus",
      "CZE" => "Czech Republic",
      "DEU" => "Germany",
      "DGA" => "Djibouti",
      "DJI" => "Djibouti",
      "DNK" => "Denmark",
      "DOM" => "Dominican Republic",
      "ECU" => "Ecuador",
      "EGY" => "Egypt",
      "ESP" => "Spain",
      "EST" => "Estonia",
      "ETH" => "Ethiopia",
      "FIN" => "Finland",
      "FJI" => "Fiji",
      "FRA" => "France",
      "GBR" => "United Kingdom",
      "GEO" => "Georgia",
      "GHA" => "Ghana",
      "GIN" => "Guinea",
      "GRC" => "Greece",
      "GRL" => "Greenland",
      "GTM" => "Guatemala",
      "GUY" => "Guyana",
      "HKG" => "Hong Kong",
      "HND" => "Honduras",
      "HTI" => "Haiti",
      "HUN" => "Hungary",
      "IDN" => "Indonesia",
      "IND" => "India",
      "IRL" => "Ireland",
      "IRQ" => "Iraq",
      "ISL" => "Iceland",
      "ISR" => "Israel",
      "ITA" => "Italy",
      "JAM" => "Jamaica",
      "JOR" => "Jordan",
      "JPN" => "Japan",
      "KAZ" => "Kazakhstan",
      "KEN" => "Kenya",
      "KGZ" => "Kyrgyzstan",
      "KHM" => "Cambodia",
      "KIR" => "Kiribati",
      "KOR" => "South Korea",
      "KWT" => "Kuwait",
      "LAO" => "Laos",
      "LBN" => "Lebanon",
      "LBR" => "Liberia",
      "LKA" => "Sri Lanka",
      "LSO" => "Lesotho",
      "LTU" => "Lithuania",
      "LUX" => "Luxembourg",
      "LVA" => "Latvia",
      "MAR" => "Morocco",
      "MDA" => "Moldova",
      "MDG" => "Madagascar",
      "MDV" => "Maldives",
      "MEX" => "Mexico",
      "MHL" => "Marshall Islands",
      "MKD" => "Macedonia",
      "MLI" => "Mali",
      "MLT" => "Malta",
      "MMR" => "Myanmar",
      "MNE" => "Montenegro",
      "MNG" => "Mongolia",
      "MOZ" => "Mozambique",
      "MRT" => "Mauritania",
      "MWI" => "Malawi",
      "MYS" => "Malaysia",
      "NAM" => "Namibia",
      "NER" => "Niger",
      "NGA" => "Nigeria",
      "NLD" => "Netherlands",
      "NOR" => "Norway",
      "NPL" => "Nepal",
      "OMN" => "Oman",
      "PAK" => "Pakistan",
      "PAN" => "Panama",
      "PER" => "Peru",
      "PHL" => "Philippines",
      "PLW" => "Palau",
      "PNG" => "Papua New Guinea",
      "POL" => "Poland",
      "PRI" => "Puerto Rico",
      "PRK" => "North Korea",
      "PRT" => "Portugal",
      "PRY" => "Paraguay",
      "QAT" => "Qatar",
      "ROU" => "Romania",
      "RUS" => "Russia",
      "RWA" => "Rwanda",
      "SAU" => "Saudi Arabia",
      "SDN" => "Sudan",
      "SEN" => "Senegal",
      "SGP" => "Singapore",
      "SHN" => "Saint Helena",
      "SLB" => "Solomon Islands",
      "SLE" => "Sierra Leone",
      "SLV" => "El Salvador",
      "SOM" => "Somalia",
      "SRB" => "Serbia",
      "SSD" => "South Sudan",
      "STP" => "Sao Tome and Principe",
      "SVK" => "Slovakia",
      "SVN" => "Slovenia",
      "SWE" => "Sweden",
      "SWZ" => "Swaziland",
      "SYR" => "Syria",
      "TCD" => "Chad",
      "TGO" => "Togo",
      "THA" => "Thailand",
      "TKM" => "Turkmenistan",
      "TLS" => "Timor-Leste",
      "TTO" => "Trinidad and Tobago",
      "TUN" => "Tunisia",
      "TUR" => "Turkey",
      "TWN" => "Taiwan",
      "TZA" => "Tanzania",
      "UGA" => "Uganda",
      "UKR" => "Ukraine",
      "URY" => "Uruguay",
      "USA" => "United States",
      "UZB" => "Uzbekistan",
      "VEN" => "Venezuela",
      "VIR" => "Virgin Islands",
      "VNM" => "Vietnam",
      "WSM" => "Samoa",
      "XGZ" => "Gaza Strip",
      "XKS" => "West Bank",
      "XWB" => "West Bank",
      "YEM" => "Yemen",
      "ZAF" => "South Africa",
      "ZMB" => "Zambia",
      "ZWE" => "Zimbabwe"
    }
  end

  def list_states do
    %{
      "AL" => "Alabama",
      "AK" => "Alaska",
      "AZ" => "Arizona",
      "AR" => "Arkansas",
      "CA" => "California",
      "CO" => "Colorado",
      "CT" => "Connecticut",
      "DE" => "Delaware",
      "FL" => "Florida",
      "GA" => "Georgia",
      "HI" => "Hawaii",
      "ID" => "Idaho",
      "IL" => "Illinois",
      "IN" => "Indiana",
      "IA" => "Iowa",
      "KS" => "Kansas",
      "KY" => "Kentucky",
      "LA" => "Louisiana",
      "ME" => "Maine",
      "MD" => "Maryland",
      "MA" => "Massachusetts",
      "MI" => "Michigan",
      "MN" => "Minnesota",
      "MS" => "Mississippi",
      "MO" => "Missouri",
      "MT" => "Montana",
      "NE" => "Nebraska",
      "NV" => "Nevada",
      "NH" => "New Hampshire",
      "NJ" => "New Jersey",
      "NM" => "New Mexico",
      "NY" => "New York",
      "NC" => "North Carolina",
      "ND" => "North Dakota",
      "OH" => "Ohio",
      "OK" => "Oklahoma",
      "OR" => "Oregon",
      "PA" => "Pennsylvania",
      "RI" => "Rhode Island",
      "SC" => "South Carolina",
      "SD" => "South Dakota",
      "TN" => "Tennessee",
      "TX" => "Texas",
      "UT" => "Utah",
      "VT" => "Vermont",
      "VA" => "Virginia",
      "WA" => "Washington",
      "WV" => "West Virginia",
      "WI" => "Wisconsin",
      "WY" => "Wyoming"
    }
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
