### Prerequisites

- A Data Product should already exist in order to attach the new components to it.
- An ADLS Gen2 Storage component must already exist on the Data Product

### Component Metadata

This section includes the basic information that any Component of Witboost must have:

- Name: Required name used for display purposes on your Data Product
- Description: A short description to help others understand what this Output Port is for.
- Domain: The Domain of the Data Product this Output Port belongs to. Be sure to choose it correctly as is a fundamental part of the Output Port and cannot be changed afterwards.
- Data Product: The Data Product this Output Port belongs to, be sure to choose the right one.
- Identifier: Unique ID for this new entity inside the domain. Don't worry to fill this field, it will be automatically filled for you.
- Development Group: Development group of this Data Product. Don't worry to fill this field, it will be automatically filled for you.
- Storage component dependency: The ADLS Gen2 Output Port component must have a single dependency, and this must be an existing ADLS Gen2 storage component present on the same data product. The options shown to the user will be picked from the data product selected by the user on the same step. The ADLS Gen2 storage account and containers information will be retrieved from the selected component.

*Example:*

| Field name                       | Example value                                                                                      |
|:---------------------------------|:---------------------------------------------------------------------------------------------------|
| **Name**                         | ADLS Gen2 Vaccinations Output Port                                                                 |
| **Description**                  | Exposes vaccinations data stored in an ADLS Gen2 folder                                            |
| **Domain**                       | domain:healthcare                                                                                  |
| **Data Product**                 | system:healthcare.vaccinationsdp.0                                                                 |
| ***Identifier***                 | Will look something like this: *healthcare.vaccinationsdp.0.adls-gen2-vaccinations-output-port*    |
| ***Development Group***          | Might look something like this: *group:platformteam* Depends on the Data Product development group |
| **Storage component dependency** | ADLSGen2-Storage                                                                                   | 

### Terms and Conditions & SLA (Editor Wizard)

Specify Terms & Conditions and Service Level Agreement information for this Output Port. This information can only be filled using the Editor Wizard

- Terms and Conditions: Required. Terms and Conditions that apply to the data exposed by the Output Port that need to be met by the consumers.
- Interval of change: Required. How often the data is refreshed.
- Timeliness: Required. Timeliness of the data.
- Timeliness: Required. Uptime of the Output Port as a percentage.

*Example:*

| Field name               | Example value                        |
|:-------------------------|:-------------------------------------|
| **Terms and Conditions** | Can be used for production purposes. |
| **Interval of change**   | 2BD                                  |
| **Timeliness**           | 2BD                                  |
| **Uptime**               | 99.9%                                |


### Data Sharing Agreement (Editor Wizard)

Specify the Data Sharing Agreement clauses for this Data Product. This information can only be filled using the Editor Wizard.

- Purpose: Required. Purpose of the data.
- Billing: Required. Billing applied to data usage, ie how consumers are charged (if they are).
- Security: Required. Security policies that apply to the data.
- Intended Usage: Required. Intended usage for the data.
- Limitations: Required. Limitations of the data.
- Lifecycle: Required. Lifecycle of the data.
- Confidentiality: Required. Confidentiality of the data.

*Example:*

| Field name      | Example value                                                                       |
|:----------------|:------------------------------------------------------------------------------------|
| Purpose         | Foundational data for downstream sue cases.                                         |
| Billing         | None.                                                                               |
| Security        | Platform standard security policies.                                                |
| Intended Usage  | Any downstream use cases.                                                           |
| Limitations     | Needs joining with other datasets (eg customer data) for most analytical use cases. |
| Lifecycle       | Data loaded every two days and typically never deleted.                             |
| Confidentiality | None.                                                                               |


### Data contract schema

Provide the schema metadata of the files stored in the folder to be created.

- Column Name: Name of the column inside the table.
- Column Data Type: Data Type of the column. Accepted values:
    - TINYINT
    - SMALLINT
    - INT
    - BIGINT
    - DOUBLE
    - DECIMAL
    - TIMESTAMP
    - DATE
    - STRING
    - CHAR
    - VARCHAR
    - BOOLEAN
    - ARRAY
- According to the chosen data type, other fields may be required.

| Name      | Data Type | Precision | Scale |
|:----------|:----------|:----------|:------|
| _id_      | INT       | -         | -     |
| _name_    | STRING    | -         | -     |
| _country_ | TEXT      | -         | -     |
| _salary_  | DECIMAL   | 14        | 9     |

### Provide ADLS Gen2 directory information

This section includes the necessary information to build the folder hierarchy inside an ADLS Gen2 instance. It allows the user to choose the container where the folder will be created from the containers created by the *Storage component dependency*.  It also allows the user for the folder path or provides the functionality to autogenerate one. When using the automatic generation feature, it allows the user to optionally write a custom prefix path to a folder where the hierarchy will be created. 

> The Storage Account name will be retrieved by the Tech Adapter from the output of the provisioning task of the dependent Storage component at deployment time, as it is generated only at runtime.

- Container name: Name of the container, chosen from the containers created by the *Storage component dependency*.
- Generate folder path automatically: Whether to generate automatically the folder path or to provide the full path
- Prefix Path: When enabling automatic generation, the user can provide a prefix path. If provided, it must end with `/`. The folder created by this component will be located in: `{{ prefixPath }}/data-products/{{ domainName }}/{{ dataProductName }}/{{ dataProductMajorVersion }}/{{ componentName }}`. All the names are normalized replacing spaces and underscores with hyphens (`-`).

*Example:*

| Field name                             | Example value    |
|:---------------------------------------|:-----------------|
| **Container name**                     | my-container     |
| **Generate folder path automatically** | ✅                |
| **Prefix Path**                        | witboost/        |

After this step, the system will show you the summary of the information provided. You can go back and edit them if you notice any mistake, otherwise you can go ahead and create the Component.

After clicking on **"Create"**, the Component registration will start. If no errors occur, it will go through the 3 phases (Fetching, Publishing and Registering) and it will show you the links to the newly created repository inside the configured repository and the new Data Product Component in the Builder Catalog.
