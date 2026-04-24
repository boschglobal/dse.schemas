package kind

import ()

type Transform struct {
	Functions *struct {
		Model *struct {
			Lua *string `yaml:"lua,omitempty"`
		} `yaml:"model,omitempty"`
		Vector *struct {
			Lua *string `yaml:"lua,omitempty"`
		} `yaml:"vector,omitempty"`
	} `yaml:"functions,omitempty"`
	Linear *struct {
		Factor float64 `yaml:"factor"`
		Offset float64 `yaml:"offset"`
	} `yaml:"linear,omitempty"`
	Timing *Timing `yaml:"timing,omitempty"`
}
