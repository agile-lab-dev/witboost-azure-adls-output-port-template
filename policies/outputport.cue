name:                     string
fullyQualifiedName?:      null | string
description:              string
kind:                     "outputport"
version:                  string & =~"^[0-9]+\\.[0-9]+\\..+$"
infrastructureTemplateId: string
useCaseTemplateId:        string
dependsOn: [string]
platform:             "Azure"
technology:           "ADLSGen2"
outputPortType:       "Files"
dataContract:         #DataContract
dataSharingAgreement: #DataSharingAgreement
tags: [...string]
readsFrom: [...string]
specific: {
	container:  string & =~"^[a-z0-9]+(?:-[a-z0-9]+)*$"
	path:       string & =~"^[^/]+(?:/[^/]+)*$"
	fileFormat: string
}

#OM_DataType: string & =~"(?i)^(TINYINT|SMALLINT|INT|BIGINT|DOUBLE|DECIMAL|TIMESTAMP|DATE|STRING|TEXT|CHAR|VARCHAR|BOOLEAN|ARRAY|MAP|STRUCT|UNION)$"
#URL:         string & =~"^https?://[a-zA-Z0-9@:%._~#=&/?]*$"
#OM_Tag: {
	tagFQN:       string
	description?: string | null
	source:       string & =~"(?i)^(Tag|Glossary)$"
	labelType:    string & =~"(?i)^(Manual|Propagated|Automated|Derived)$"
	state:        string & =~"(?i)^(Suggested|Confirmed)$"
	href?:        string | null
}

#OM_Column: {
	name:        string
	dataType:    #OM_DataType
	constraint?: string & =~"(?i)^(PRIMARY_KEY|NOT_NULL|UNIQUE)$" | null
	if dataType =~ "(?i)^(ARRAY)$" {
		arrayDataType: #OM_DataType
	}
	if dataType =~ "(?i)^(CHAR|VARCHAR|TEXT)$" {
		dataLength: int & >0 & <=16777216
	}
	if dataType =~ "(?i)^(DECIMAL)$" {
		precision: int & >0 & <=38
		scale:     int & >=0 & <=(precision - 1)
	}
	dataTypeDisplay?:    string | null
	description?:        string | null
	fullyQualifiedName?: string | null
	tags?: [... #OM_Tag]
	if dataType =~ "(?i)^(MAP|STRUCT|UNION)$" {
		children: [... #OM_Column]
	}
}

#DataContract: {
	schema: [#OM_Column, ... #OM_Column]
	SLA: {
		intervalOfChange?: string | null
		timeliness?:       string | null
		upTime?:           string | null
		...
	}
	termsAndConditions?: string | null
	endpoint?:           #URL | null
	biTempBusinessTs?:   string | null
	biTempWriteTs?:      string | null
	...
}

#DataSharingAgreement: {
	purpose?:         string | null
	billing?:         string | null
	security?:        string | null
	intendedUsage?:   string | null
	limitations?:     string | null
	lifeCycle?:       string | null
	confidentiality?: string | null
	...
}
