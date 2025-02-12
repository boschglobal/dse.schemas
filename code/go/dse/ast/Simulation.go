package ast

import ()

const (
	SimulationKindSimulation SimulationKind = "Simulation"
)
const (
	VarReferenceUses VarReference = "uses"
)

type Model struct {
	Arch      *string                 `yaml:"arch,omitempty"`
	Channels  []ModelChannel          `yaml:"channels"`
	Env       *[]Var                  `yaml:"env,omitempty"`
	Files     *[]string               `yaml:"files,omitempty"`
	Metadata  *map[string]interface{} `yaml:"metadata,omitempty"`
	Model     string                  `yaml:"model"`
	Name      string                  `yaml:"name"`
	Uses      string                  `yaml:"uses"`
	Workflows *[]Workflow             `yaml:"workflows,omitempty"`
}
type ModelChannel struct {
	Alias string `yaml:"alias"`
	Name  string `yaml:"name"`
}
type Simulation struct {
	Kind     SimulationKind  `yaml:"kind"`
	Metadata *ObjectMetadata `yaml:"metadata,omitempty"`
	Spec     SimulationSpec  `yaml:"spec"`
}
type SimulationKind string
type SimulationChannel struct {
	Name     string               `yaml:"name"`
	Networks *[]SimulationNetwork `yaml:"networks,omitempty"`
}
type SimulationNetwork struct {
	MimeType string `yaml:"mime_type"`
	Name     string `yaml:"name"`
}
type SimulationSpec struct {
	Arch     string              `yaml:"arch"`
	Channels []SimulationChannel `yaml:"channels"`
	Stacks   []Stack             `yaml:"stacks"`
	Uses     *[]Uses             `yaml:"uses,omitempty"`
	Vars     *[]Var              `yaml:"vars,omitempty"`
}
type Stack struct {
	Arch    *string `yaml:"arch,omitempty"`
	Env     *[]Var  `yaml:"env,omitempty"`
	Models  []Model `yaml:"models"`
	Name    string  `yaml:"name"`
	Stacked *bool   `yaml:"stacked,omitempty"`
}
type Uses struct {
	Metadata *map[string]interface{} `yaml:"metadata,omitempty"`
	Name     string                  `yaml:"name"`
	Path     *string                 `yaml:"path,omitempty"`
	Url      string                  `yaml:"url"`
	Version  *string                 `yaml:"version,omitempty"`
}
type Var struct {
	Name      string        `yaml:"name"`
	Reference *VarReference `yaml:"reference,omitempty"`
	Value     string        `yaml:"value"`
}
type VarReference string
type Workflow struct {
	Name string  `yaml:"name"`
	Uses *string `yaml:"uses,omitempty"`
	Vars *[]Var  `yaml:"vars,omitempty"`
}
