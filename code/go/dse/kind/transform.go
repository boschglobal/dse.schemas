package kind

import ()

type Transform struct {
	Functions *struct {
		Model  *LuaFunction `yaml:"model,omitempty"`
		Vector *LuaFunction `yaml:"vector,omitempty"`
	} `yaml:"functions,omitempty"`
	Linear *struct {
		Factor float64 `yaml:"factor"`
		Offset float64 `yaml:"offset"`
	} `yaml:"linear,omitempty"`
}
