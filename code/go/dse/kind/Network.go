package kind

import ()

const (
	NetworkKindNetwork NetworkKind = "Network"
)

type Function struct {
	Annotations *Annotations `yaml:"annotations,omitempty"`
	Function    string       `yaml:"function"`
}
type Message struct {
	Annotations *Annotations `yaml:"annotations,omitempty"`
	Functions   *struct {
		Decode *[]Function `yaml:"decode,omitempty"`
		Encode *[]Function `yaml:"encode,omitempty"`
	} `yaml:"functions,omitempty"`
	Message string           `yaml:"message"`
	Signals *[]NetworkSignal `yaml:"signals,omitempty"`
}
type Network struct {
	Kind     NetworkKind     `yaml:"kind"`
	Metadata *ObjectMetadata `yaml:"metadata,omitempty"`
	Spec     NetworkSpec     `yaml:"spec"`
}
type NetworkKind string
type NetworkSignal struct {
	Annotations *Annotations `yaml:"annotations,omitempty"`
	Signal      string       `yaml:"signal"`
}
type NetworkSpec struct {
	Messages []Message `yaml:"messages"`
}
