package kind

type Annotations map[string]string
type Labels map[string]string
type ObjectMetadata struct {
	Annotations *Annotations `yaml:"annotations,omitempty"`
	Labels      *Labels      `yaml:"labels,omitempty"`
	Name        *string      `yaml:"name,omitempty"`
}
