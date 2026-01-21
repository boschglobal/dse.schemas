package kind

import (
	"encoding/json"
	"github.com/oapi-codegen/runtime"
)

const (
	Data     CanFrameType = Data
	Error    CanFrameType = Error
	Overload CanFrameType = Overload
	Remote   CanFrameType = Remote
)
const (
	Base       CanMessageFormat = Base
	Extended   CanMessageFormat = Extended
	FdBase     CanMessageFormat = FdBase
	FdExtended CanMessageFormat = FdExtended
)
const (
	BR10Mbps FlexrayBitrate = BR10Mbps
	BR25Mbps FlexrayBitrate = BR2_5Mbps
	BR5Mbps  FlexrayBitrate = BR5Mbps
)
const (
	Pop FlexrayBusModelMode = Pop
)
const (
	A  FlexrayChannel = A
	AB FlexrayChannel = AB
	B  FlexrayChannel = B
)
const (
	Rx FlexrayDirection = Rx
	Tx FlexrayDirection = Tx
)
const (
	FlexrayPocStateN0 FlexrayPocState = 0
	FlexrayPocStateN1 FlexrayPocState = 1
	FlexrayPocStateN2 FlexrayPocState = 2
	FlexrayPocStateN3 FlexrayPocState = 3
	FlexrayPocStateN4 FlexrayPocState = 4
	FlexrayPocStateN5 FlexrayPocState = 5
	FlexrayPocStateN6 FlexrayPocState = 6
	FlexrayPocStateN7 FlexrayPocState = 7
	FlexrayPocStateN8 FlexrayPocState = 8
	FlexrayPocStateN9 FlexrayPocState = 9
)
const (
	Continuous FlexrayTransmitMode = Continuous
	SingleShot FlexrayTransmitMode = SingleShot
)
const (
	IpProtocolN0  IpProtocol = 0
	IpProtocolN17 IpProtocol = 17
	IpProtocolN6  IpProtocol = 6
)

type CanFrameType int
type CanMessageFormat int
type CanMessageMetadata struct {
	FrameType     *CanFrameType     `yaml:"frame_type,omitempty"`
	InterfaceId   *int              `yaml:"interface_id,omitempty"`
	MessageFormat *CanMessageFormat `yaml:"message_format,omitempty"`
	NetworkId     *int              `yaml:"network_id,omitempty"`
}
type DoIpMetadata struct {
	PayloadType     int `yaml:"payload_type"`
	ProtocolVersion int `yaml:"protocol_version"`
}
type FlexrayBitrate int
type FlexrayBusModelMode int
type FlexrayChannel int
type FlexrayConfig struct {
	BitRate                 *FlexrayBitrate          `yaml:"bit_rate,omitempty"`
	BusModelMode            *FlexrayBusModelMode     `yaml:"bus_model_mode,omitempty"`
	ChannelEnable           *FlexrayChannel          `yaml:"channel_enable,omitempty"`
	InhibitNullFrames       *bool                    `yaml:"inhibit_null_frames,omitempty"`
	InitialPocStateCha      *FlexrayPocState         `yaml:"initial_poc_state_cha,omitempty"`
	InitialPocStateChb      *FlexrayPocState         `yaml:"initial_poc_state_chb,omitempty"`
	MacrotickPerCycle       *int                     `yaml:"macrotick_per_cycle,omitempty"`
	MicrotickPerCycle       *int                     `yaml:"microtick_per_cycle,omitempty"`
	MinislotCount           *int                     `yaml:"minislot_count,omitempty"`
	MinislotLength          *int                     `yaml:"minislot_length,omitempty"`
	NetworkIdleStart        *int                     `yaml:"network_idle_start,omitempty"`
	NodeName                *string                  `yaml:"node_name,omitempty"`
	SingleSlotEnabled       *bool                    `yaml:"single_slot_enabled,omitempty"`
	StaticSlotCount         *int                     `yaml:"static_slot_count,omitempty"`
	StaticSlotLength        *int                     `yaml:"static_slot_length,omitempty"`
	StaticSlotPayloadLength *int                     `yaml:"static_slot_payload_length,omitempty"`
	Vcn                     *[]FlexrayNodeIdentifier `yaml:"vcn,omitempty"`
	WakeupChannelSelect     *int                     `yaml:"wakeup_channel_select,omitempty"`
}
type FlexrayDirection int
type FlexrayMetadata struct {
	BaseCycle       *int                 `yaml:"base_cycle,omitempty"`
	Channel         *FlexrayChannel      `yaml:"channel,omitempty"`
	CycleRepetition *int                 `yaml:"cycle_repetition,omitempty"`
	Direction       *FlexrayDirection    `yaml:"direction,omitempty"`
	InhibitNull     *bool                `yaml:"inhibit_null,omitempty"`
	PayloadLength   *int                 `yaml:"payload_length,omitempty"`
	SlotId          *int                 `yaml:"slot_id,omitempty"`
	TransmitMode    *FlexrayTransmitMode `yaml:"transmit_mode,omitempty"`
}
type FlexrayNodeIdentifier struct {
	CcId  *int `yaml:"cc_id,omitempty"`
	EcuId *int `yaml:"ecu_id,omitempty"`
	SwcId *int `yaml:"swc_id,omitempty"`
}
type FlexrayPocState int
type FlexrayTransmitMode int
type IpAddr struct {
	union json.RawMessage
}
type IpAddressV6 struct {
	V0 *int `yaml:"v0,omitempty"`
	V1 *int `yaml:"v1,omitempty"`
	V2 *int `yaml:"v2,omitempty"`
	V3 *int `yaml:"v3,omitempty"`
	V4 *int `yaml:"v4,omitempty"`
	V5 *int `yaml:"v5,omitempty"`
	V6 *int `yaml:"v6,omitempty"`
	V7 *int `yaml:"v7,omitempty"`
}
type IpMessageMetadata struct {
	Adapter      *SocketAdapter `yaml:"adapter,omitempty"`
	EthDstMac    *int           `yaml:"eth_dst_mac,omitempty"`
	EthEthertype *int           `yaml:"eth_ethertype,omitempty"`
	EthSrcMac    *int           `yaml:"eth_src_mac,omitempty"`
	EthTciDei    *int           `yaml:"eth_tci_dei,omitempty"`
	EthTciPcp    *int           `yaml:"eth_tci_pcp,omitempty"`
	EthTciVid    *int           `yaml:"eth_tci_vid,omitempty"`
	IpAddr       *IpAddr        `yaml:"ip_addr,omitempty"`
	IpDstPort    *int           `yaml:"ip_dst_port,omitempty"`
	IpProtocol   *IpProtocol    `yaml:"ip_protocol,omitempty"`
	IpSrcPort    *int           `yaml:"ip_src_port,omitempty"`
}
type IpProtocol int
type IpV4 struct {
	DstAddr int `yaml:"dst_addr"`
	SrcAddr int `yaml:"src_addr"`
}
type IpV6 struct {
	DstAddr IpAddressV6 `yaml:"dst_addr"`
	SrcAddr IpAddressV6 `yaml:"src_addr"`
}
type LuaFunction struct {
	Lua string `yaml:"lua"`
}
type LuaFunctions struct {
	Decode *[]LuaFunction `yaml:"decode,omitempty"`
	Encode *[]LuaFunction `yaml:"encode,omitempty"`
}
type Pdu struct {
	Annotations *Annotations  `yaml:"annotations,omitempty"`
	Container   *int          `yaml:"container,omitempty"`
	Functions   *LuaFunctions `yaml:"functions,omitempty"`
	Id          int           `yaml:"id"`
	Length      int           `yaml:"length"`
	Metadata    *PduMetadata  `yaml:"metadata,omitempty"`
	Pdu         *string       `yaml:"pdu,omitempty"`
	Signals     []PduSignal   `yaml:"signals"`
}
type PduContainer struct {
	Pdu PduEncodingBytes `yaml:"pdu"`
}
type PduEncodingBytes struct {
	Length int `yaml:"length"`
	Start  int `yaml:"start"`
}
type PduMetadata struct {
	union json.RawMessage
}
type PduMetadata0 struct {
	Can CanMessageMetadata `yaml:"can"`
}
type PduMetadata1 struct {
	Flexray FlexrayMetadata `yaml:"flexray"`
}
type PduMetadata2 struct {
	Ip IpMessageMetadata `yaml:"ip"`
}
type PduMetadata3 struct {
	Struct StructMetadata `yaml:"struct"`
}
type PduMultiplexer struct {
	Multiplexor PduEncodingBytes `yaml:"multiplexor"`
}
type PduSignal struct {
	union json.RawMessage
}
type PduSignalEncoding struct {
	Factor *float32 `yaml:"factor,omitempty"`
	Length int      `yaml:"length"`
	Max    *float32 `yaml:"max,omitempty"`
	Min    *float32 `yaml:"min,omitempty"`
	Offset *float32 `yaml:"offset,omitempty"`
	Start  int      `yaml:"start"`
}
type PduSignalScalar struct {
	Annotations *Annotations       `yaml:"annotations,omitempty"`
	Encoding    *PduSignalEncoding `yaml:"encoding,omitempty"`
	Functions   *LuaFunctions      `yaml:"functions,omitempty"`
	Signal      string             `yaml:"signal"`
}
type SocketAdapter struct {
	union json.RawMessage
}
type SomeIpMetadata struct {
	InterfaceVersion int `yaml:"interface_version"`
	Length           int `yaml:"length"`
	MessageId        int `yaml:"message_id"`
	MessageType      int `yaml:"message_type"`
	ProtocolVersion  int `yaml:"protocol_version"`
	RequestId        int `yaml:"request_id"`
	ReturnCode       int `yaml:"return_code"`
}
type StructMetadata struct {
	AttributeAligned *int    `yaml:"attribute_aligned,omitempty"`
	AttributePacked  *bool   `yaml:"attribute_packed,omitempty"`
	Encoding         *string `yaml:"encoding,omitempty"`
	PlatformAbi      *string `yaml:"platform_abi,omitempty"`
	PlatformArch     *string `yaml:"platform_arch,omitempty"`
	PlatformOs       *string `yaml:"platform_os,omitempty"`
	TypeName         *string `yaml:"type_name,omitempty"`
	VarName          *string `yaml:"var_name,omitempty"`
}

func (t IpAddr) AsIpV4() (IpV4, error) {
	var body IpV4
	err := json.Unmarshal(t.union, &body)
	return body, err
}
func (t *IpAddr) FromIpV4(v IpV4) error {
	b, err := json.Marshal(v)
	t.union = b
	return err
}
func (t *IpAddr) MergeIpV4(v IpV4) error {
	b, err := json.Marshal(v)
	if err != nil {
		return err
	}
	merged, err := runtime.JSONMerge(t.union, b)
	t.union = merged
	return err
}
func (t IpAddr) AsIpV6() (IpV6, error) {
	var body IpV6
	err := json.Unmarshal(t.union, &body)
	return body, err
}
func (t *IpAddr) FromIpV6(v IpV6) error {
	b, err := json.Marshal(v)
	t.union = b
	return err
}
func (t *IpAddr) MergeIpV6(v IpV6) error {
	b, err := json.Marshal(v)
	if err != nil {
		return err
	}
	merged, err := runtime.JSONMerge(t.union, b)
	t.union = merged
	return err
}
func (t IpAddr) MarshalJSON() ([]byte, error) {
	b, err := t.union.MarshalJSON()
	return b, err
}
func (t *IpAddr) UnmarshalJSON(b []byte) error {
	err := t.union.UnmarshalJSON(b)
	return err
}
func (t PduMetadata) AsPduMetadata0() (PduMetadata0, error) {
	var body PduMetadata0
	err := json.Unmarshal(t.union, &body)
	return body, err
}
func (t *PduMetadata) FromPduMetadata0(v PduMetadata0) error {
	b, err := json.Marshal(v)
	t.union = b
	return err
}
func (t *PduMetadata) MergePduMetadata0(v PduMetadata0) error {
	b, err := json.Marshal(v)
	if err != nil {
		return err
	}
	merged, err := runtime.JSONMerge(t.union, b)
	t.union = merged
	return err
}
func (t PduMetadata) AsPduMetadata1() (PduMetadata1, error) {
	var body PduMetadata1
	err := json.Unmarshal(t.union, &body)
	return body, err
}
func (t *PduMetadata) FromPduMetadata1(v PduMetadata1) error {
	b, err := json.Marshal(v)
	t.union = b
	return err
}
func (t *PduMetadata) MergePduMetadata1(v PduMetadata1) error {
	b, err := json.Marshal(v)
	if err != nil {
		return err
	}
	merged, err := runtime.JSONMerge(t.union, b)
	t.union = merged
	return err
}
func (t PduMetadata) AsPduMetadata2() (PduMetadata2, error) {
	var body PduMetadata2
	err := json.Unmarshal(t.union, &body)
	return body, err
}
func (t *PduMetadata) FromPduMetadata2(v PduMetadata2) error {
	b, err := json.Marshal(v)
	t.union = b
	return err
}
func (t *PduMetadata) MergePduMetadata2(v PduMetadata2) error {
	b, err := json.Marshal(v)
	if err != nil {
		return err
	}
	merged, err := runtime.JSONMerge(t.union, b)
	t.union = merged
	return err
}
func (t PduMetadata) AsPduMetadata3() (PduMetadata3, error) {
	var body PduMetadata3
	err := json.Unmarshal(t.union, &body)
	return body, err
}
func (t *PduMetadata) FromPduMetadata3(v PduMetadata3) error {
	b, err := json.Marshal(v)
	t.union = b
	return err
}
func (t *PduMetadata) MergePduMetadata3(v PduMetadata3) error {
	b, err := json.Marshal(v)
	if err != nil {
		return err
	}
	merged, err := runtime.JSONMerge(t.union, b)
	t.union = merged
	return err
}
func (t PduMetadata) MarshalJSON() ([]byte, error) {
	b, err := t.union.MarshalJSON()
	return b, err
}
func (t *PduMetadata) UnmarshalJSON(b []byte) error {
	err := t.union.UnmarshalJSON(b)
	return err
}
func (t PduSignal) AsPduMultiplexer() (PduMultiplexer, error) {
	var body PduMultiplexer
	err := json.Unmarshal(t.union, &body)
	return body, err
}
func (t *PduSignal) FromPduMultiplexer(v PduMultiplexer) error {
	b, err := json.Marshal(v)
	t.union = b
	return err
}
func (t *PduSignal) MergePduMultiplexer(v PduMultiplexer) error {
	b, err := json.Marshal(v)
	if err != nil {
		return err
	}
	merged, err := runtime.JSONMerge(t.union, b)
	t.union = merged
	return err
}
func (t PduSignal) AsPduContainer() (PduContainer, error) {
	var body PduContainer
	err := json.Unmarshal(t.union, &body)
	return body, err
}
func (t *PduSignal) FromPduContainer(v PduContainer) error {
	b, err := json.Marshal(v)
	t.union = b
	return err
}
func (t *PduSignal) MergePduContainer(v PduContainer) error {
	b, err := json.Marshal(v)
	if err != nil {
		return err
	}
	merged, err := runtime.JSONMerge(t.union, b)
	t.union = merged
	return err
}
func (t PduSignal) AsPduSignalScalar() (PduSignalScalar, error) {
	var body PduSignalScalar
	err := json.Unmarshal(t.union, &body)
	return body, err
}
func (t *PduSignal) FromPduSignalScalar(v PduSignalScalar) error {
	b, err := json.Marshal(v)
	t.union = b
	return err
}
func (t *PduSignal) MergePduSignalScalar(v PduSignalScalar) error {
	b, err := json.Marshal(v)
	if err != nil {
		return err
	}
	merged, err := runtime.JSONMerge(t.union, b)
	t.union = merged
	return err
}
func (t PduSignal) MarshalJSON() ([]byte, error) {
	b, err := t.union.MarshalJSON()
	return b, err
}
func (t *PduSignal) UnmarshalJSON(b []byte) error {
	err := t.union.UnmarshalJSON(b)
	return err
}
func (t SocketAdapter) AsDoIpMetadata() (DoIpMetadata, error) {
	var body DoIpMetadata
	err := json.Unmarshal(t.union, &body)
	return body, err
}
func (t *SocketAdapter) FromDoIpMetadata(v DoIpMetadata) error {
	b, err := json.Marshal(v)
	t.union = b
	return err
}
func (t *SocketAdapter) MergeDoIpMetadata(v DoIpMetadata) error {
	b, err := json.Marshal(v)
	if err != nil {
		return err
	}
	merged, err := runtime.JSONMerge(t.union, b)
	t.union = merged
	return err
}
func (t SocketAdapter) AsSomeIpMetadata() (SomeIpMetadata, error) {
	var body SomeIpMetadata
	err := json.Unmarshal(t.union, &body)
	return body, err
}
func (t *SocketAdapter) FromSomeIpMetadata(v SomeIpMetadata) error {
	b, err := json.Marshal(v)
	t.union = b
	return err
}
func (t *SocketAdapter) MergeSomeIpMetadata(v SomeIpMetadata) error {
	b, err := json.Marshal(v)
	if err != nil {
		return err
	}
	merged, err := runtime.JSONMerge(t.union, b)
	t.union = merged
	return err
}
func (t SocketAdapter) MarshalJSON() ([]byte, error) {
	b, err := t.union.MarshalJSON()
	return b, err
}
func (t *SocketAdapter) UnmarshalJSON(b []byte) error {
	err := t.union.UnmarshalJSON(b)
	return err
}
