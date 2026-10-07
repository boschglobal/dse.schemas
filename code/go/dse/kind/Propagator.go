package kind

import ()

const (
	PropagatorKindPropagator PropagatorKind = "Propagator"
)

func (e PropagatorKind) Valid() bool {
	switch e {
	case PropagatorKindPropagator:
		return true
	default:
		return false
	}
}

const (
	Both    PropagatorSpecOptionsDirection = "both"
	Forward PropagatorSpecOptionsDirection = "forward"
	Reverse PropagatorSpecOptionsDirection = "reverse"
)

func (e PropagatorSpecOptionsDirection) Valid() bool {
	switch e {
	case Both:
		return true
	case Forward:
		return true
	case Reverse:
		return true
	default:
		return false
	}
}

type Propagator struct {
	Kind     PropagatorKind  `yaml:"kind"`
	Metadata *ObjectMetadata `yaml:"metadata,omitempty"`
	Spec     PropagatorSpec  `yaml:"spec"`
}
type PropagatorKind string
type PropagatorSpec struct {
	Options *struct {
		Direction *PropagatorSpecOptionsDirection `yaml:"direction,omitempty"`
	} `yaml:"options,omitempty"`
	Signals *[]SignalEncoding `yaml:"signals,omitempty"`
}
type PropagatorSpecOptionsDirection string
type SignalEncoding struct {
	Encoding *struct {
		Linear *struct {
			Factor *float32 `yaml:"factor,omitempty"`
			Max    *float32 `yaml:"max,omitempty"`
			Min    *float32 `yaml:"min,omitempty"`
			Offset *float32 `yaml:"offset,omitempty"`
		} `yaml:"linear,omitempty"`
		Mapping *[]struct {
			Name  *string `yaml:"name,omitempty"`
			Range *struct {
				Max *float32 `yaml:"max,omitempty"`
				Min *float32 `yaml:"min,omitempty"`
			} `yaml:"range,omitempty"`
			Source *float32 `yaml:"source,omitempty"`
			Target *float32 `yaml:"target,omitempty"`
		} `yaml:"mapping,omitempty"`
	} `yaml:"encoding,omitempty"`
	Signal string  `yaml:"signal"`
	Target *string `yaml:"target,omitempty"`
}
