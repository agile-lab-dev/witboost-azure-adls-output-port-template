{%- set domainNameNormalized = values.domain | replace("domain:", "") | replace(r/ |_/g, "-") | lower %}
{%- set dataProductNameNormalized = values.dataproduct.split(".")[1] | replace(r/ |_/g, "-") | lower %}
{%- set componentNameNormalized = values.name | replace(r/ |_/g, "-") | lower %}
{%- set dataProductMajorVersion = values.identifier.split(".")[2] -%}
## Component Information

| Field Name               | Value                            |
|:-------------------------|:---------------------------------|
| **Name**                 | ${{ values.name }}               |
| **Fully Qualified Name** | ${{ values.fullyQualifiedName }} |
| **Description**          | ${{ values.description }}        |
| **Domain**               | ${{ values.domain }}             |
| **Data Product**         | ${{ values.dataproduct }}        |
| **Identifier**           | ${{ values.identifier }}         |
| **Depends On**           | ${{ values.dependsOn }}          |

{% if values.schemaColumns | length > 0 %}
## Data contract schema

| Column | Data type | Description |
|:-------|:----------|:------------|
{%- for column in values.schemaColumns %}
| ${{ column.name }} | ${{ column.dataType }} | ${{ column.description if column.description else "-" }} |
{%- endfor %}

For other details about each column, please refer to this component `catalog-info.yaml`
{%- endif %}

## Azure ADLS Gen2 folder information

| Field Name      | Value |
|:----------------|:---|
| Storage Account | ${{ values.storageAccount }} |
| Container       | ${{ values.containerName }} | 
| Folder path     | {% if values.autogeneratePath %}${{ values.prefixPath if values.prefixPath else "" }}data-products/${{ domainNameNormalized }}/${{ dataProductNameNormalized }}/${{ dataProductMajorVersion }}/${{ componentNameNormalized }}{% else %}${{ values.folderPath }}{% endif %} |
| Files Format    | ${{ values.fileFormat if values.fileFormat != "Other" else values.otherFileFormat }} |

The exposed folder will be located in `{%- if values.autogeneratePath %}${{ values.prefixPath if values.prefixPath else "" }}data-products/${{ domainNameNormalized }}/${{ dataProductNameNormalized }}/${{ dataProductMajorVersion }}/${{ componentNameNormalized }}{% else %}${{ values.folderPath }}{% endif %}`.