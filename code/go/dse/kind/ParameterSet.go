package kind

import ()

const (
	ParameterSetKindParameterSet ParameterSetKind = "ParameterSet"
)

func (e ParameterSetKind) Valid() bool {
	switch e {
	case ParameterSetKindParameterSet:
		return true
	default:
		return false
	}
}

type Parameter struct {
	Annotations *Annotations `yaml:"annotations,omitempty"`
	Parameter   string       `yaml:"parameter"`
	Value       *string      `yaml:"value,omitempty"`
}
type ParameterSet struct {
	Kind     ParameterSetKind `yaml:"kind"`
	Metadata *ObjectMetadata  `yaml:"metadata,omitempty"`
	Spec     ParameterSetSpec `yaml:"spec"`
}
type ParameterSetKind string
type ParameterSetSpec struct {
	Parameters []Parameter `yaml:"parameters"`
}
