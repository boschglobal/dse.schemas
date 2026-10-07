package kind

import ()

const (
	RunnableKindRunnable RunnableKind = "Runnable"
)

func (e RunnableKind) Valid() bool {
	switch e {
	case RunnableKindRunnable:
		return true
	default:
		return false
	}
}

type Runnable struct {
	Kind     RunnableKind    `yaml:"kind"`
	Metadata *ObjectMetadata `yaml:"metadata,omitempty"`
	Spec     RunnableSpec    `yaml:"spec"`
}
type RunnableKind string
type RunnableSpec struct {
	Tasks []Task `yaml:"tasks"`
}
type Task struct {
	Function string `yaml:"function"`
	Schedule int    `yaml:"schedule"`
}
