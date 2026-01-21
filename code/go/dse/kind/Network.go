package kind

import (
	"encoding/json"
	"fmt"
	"github.com/oapi-codegen/runtime"
)

const (
	NetworkKindNetwork NetworkKind = "Network"
)

type Network struct {
	Kind     NetworkKind     `yaml:"kind"`
	Metadata *ObjectMetadata `yaml:"metadata,omitempty"`
	Spec     NetworkSpec     `yaml:"spec"`
}
type NetworkKind string
type NetworkFunction struct {
	Annotations *Annotations `yaml:"annotations,omitempty"`
	Function    string       `yaml:"function"`
}
type NetworkFunctions struct {
	Decode *[]NetworkFunction `yaml:"decode,omitempty"`
	Encode *[]NetworkFunction `yaml:"encode,omitempty"`
}
type NetworkMessage struct {
	Annotations *Annotations      `yaml:"annotations,omitempty"`
	Functions   *NetworkFunctions `yaml:"functions,omitempty"`
	Message     string            `yaml:"message"`
	Signals     *[]NetworkSignal  `yaml:"signals,omitempty"`
}
type NetworkMetadata struct {
	union json.RawMessage
}
type NetworkMetadata0 struct {
	Flexray FlexrayConfig `yaml:"flexray"`
}
type NetworkSignal struct {
	Annotations *Annotations `yaml:"annotations,omitempty"`
	Signal      string       `yaml:"signal"`
}
type NetworkSpec struct {
	Messages *[]NetworkMessage `yaml:"messages,omitempty"`
	Metadata *NetworkMetadata  `yaml:"metadata,omitempty"`
	Pdus     *[]Pdu            `yaml:"pdus,omitempty"`
	union    json.RawMessage
}
type NetworkSpec0 = interface{}
type NetworkSpec1 = interface{}

func (t NetworkMetadata) AsNetworkMetadata0() (NetworkMetadata0, error) {
	var body NetworkMetadata0
	err := json.Unmarshal(t.union, &body)
	return body, err
}
func (t *NetworkMetadata) FromNetworkMetadata0(v NetworkMetadata0) error {
	b, err := json.Marshal(v)
	t.union = b
	return err
}
func (t *NetworkMetadata) MergeNetworkMetadata0(v NetworkMetadata0) error {
	b, err := json.Marshal(v)
	if err != nil {
		return err
	}
	merged, err := runtime.JSONMerge(t.union, b)
	t.union = merged
	return err
}
func (t NetworkMetadata) MarshalJSON() ([]byte, error) {
	b, err := t.union.MarshalJSON()
	return b, err
}
func (t *NetworkMetadata) UnmarshalJSON(b []byte) error {
	err := t.union.UnmarshalJSON(b)
	return err
}
func (t NetworkSpec) AsNetworkSpec0() (NetworkSpec0, error) {
	var body NetworkSpec0
	err := json.Unmarshal(t.union, &body)
	return body, err
}
func (t *NetworkSpec) FromNetworkSpec0(v NetworkSpec0) error {
	b, err := json.Marshal(v)
	t.union = b
	return err
}
func (t *NetworkSpec) MergeNetworkSpec0(v NetworkSpec0) error {
	b, err := json.Marshal(v)
	if err != nil {
		return err
	}
	merged, err := runtime.JSONMerge(t.union, b)
	t.union = merged
	return err
}
func (t NetworkSpec) AsNetworkSpec1() (NetworkSpec1, error) {
	var body NetworkSpec1
	err := json.Unmarshal(t.union, &body)
	return body, err
}
func (t *NetworkSpec) FromNetworkSpec1(v NetworkSpec1) error {
	b, err := json.Marshal(v)
	t.union = b
	return err
}
func (t *NetworkSpec) MergeNetworkSpec1(v NetworkSpec1) error {
	b, err := json.Marshal(v)
	if err != nil {
		return err
	}
	merged, err := runtime.JSONMerge(t.union, b)
	t.union = merged
	return err
}
func (t NetworkSpec) MarshalJSON() ([]byte, error) {
	b, err := t.union.MarshalJSON()
	if err != nil {
		return nil, err
	}
	object := make(map[string]json.RawMessage)
	if t.union != nil {
		err = json.Unmarshal(b, &object)
		if err != nil {
			return nil, err
		}
	}
	if t.Messages != nil {
		object["messages"], err = json.Marshal(t.Messages)
		if err != nil {
			return nil, fmt.Errorf("error marshaling 'messages': %w", err)
		}
	}
	if t.Metadata != nil {
		object["metadata"], err = json.Marshal(t.Metadata)
		if err != nil {
			return nil, fmt.Errorf("error marshaling 'metadata': %w", err)
		}
	}
	if t.Pdus != nil {
		object["pdus"], err = json.Marshal(t.Pdus)
		if err != nil {
			return nil, fmt.Errorf("error marshaling 'pdus': %w", err)
		}
	}
	b, err = json.Marshal(object)
	return b, err
}
func (t *NetworkSpec) UnmarshalJSON(b []byte) error {
	err := t.union.UnmarshalJSON(b)
	if err != nil {
		return err
	}
	object := make(map[string]json.RawMessage)
	err = json.Unmarshal(b, &object)
	if err != nil {
		return err
	}
	if raw, found := object["messages"]; found {
		err = json.Unmarshal(raw, &t.Messages)
		if err != nil {
			return fmt.Errorf("error reading 'messages': %w", err)
		}
	}
	if raw, found := object["metadata"]; found {
		err = json.Unmarshal(raw, &t.Metadata)
		if err != nil {
			return fmt.Errorf("error reading 'metadata': %w", err)
		}
	}
	if raw, found := object["pdus"]; found {
		err = json.Unmarshal(raw, &t.Pdus)
		if err != nil {
			return fmt.Errorf("error reading 'pdus': %w", err)
		}
	}
	return err
}
