package kind

type Timing struct {
	Interval *float32 `yaml:"interval,omitempty"`
	Phase    *float32 `yaml:"phase,omitempty"`
}
