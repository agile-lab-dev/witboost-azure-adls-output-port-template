import "list"

import "strings"

#Component: {
	kind:                     string & =~"(?-i)^(outputport|workload|storage|observability)$"
	useCaseTemplateId:        string
	infrastructureTemplateId: string
	if kind != _|_ {
		if kind =~ "(?-i)^(outputport)$" && useCaseTemplateId == "urn:dmb:utm:azure-outputport-adlsgen2-template:0.0.0" {
			#OutputPort
		}
	}
	...
}

#OutputPort: {
	id: string
	specific: {
		path:       string
		fileFormat: string
		...
	}
	...
}

original: {
	components: [...#Component]
	...
}

current: {
	components: [...#Component]
	...
}

_checks: {
	// Extract ADLS output ports id + fields to check for immutability (path and fileFormat)
	originalADLSOutputPorts: [for n in original.components if n.kind == "outputport" && n.useCaseTemplateId == "urn:dmb:utm:azure-outputport-adlsgen2-template:0.0.0" {
		id:         n.id
		path:       n.specific.path
		fileFormat: n.specific.fileFormat
	}]

	currentADLSOutputPorts: [for n in current.components if n.kind == "outputport" && n.useCaseTemplateId == "urn:dmb:utm:azure-outputport-adlsgen2-template:0.0.0" {
		id:         n.id
		path:       n.specific.path
		fileFormat: n.specific.fileFormat
	}]

	// Check that all matching output port components have the same values for immutable fields (path and fileFormat)
	mismatchOutputPorts: [for missing in originalADLSOutputPorts if !list.Contains(currentADLSOutputPorts, missing) {missing}]
	_checkMismatchOutputPorts: len(mismatchOutputPorts) & <=0
}
