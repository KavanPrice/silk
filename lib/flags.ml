type parse_error = Invalid_flags of string
type qos = QoS0 | QoS1 | QoS2
type publish_flags = { dup : bool; qos : qos; retain : bool }
type fixed_header_flags = Publish of publish_flags | Reserved

let parse_fixed_header_flags packet_type flags =
  match packet_type with
  | Packet_type.PUBLISH -> (
      let dup = flags land 0b1000 <> 0 in
      let qos_bits = (flags land 0b0110) lsr 1 in
      let retain = flags land 0b0001 <> 0 in
      match qos_bits with
      | 0 -> Ok (Publish { dup; qos = QoS0; retain })
      | 1 -> Ok (Publish { dup; qos = QoS1; retain })
      | 2 -> Ok (Publish { dup; qos = QoS2; retain })
      | _ -> Error (Invalid_flags "QoS bits set to reserved value 0b11"))
  | Packet_type.PUBREL | Packet_type.SUBSCRIBE | Packet_type.UNSUBSCRIBE ->
      if flags = 0b0010 then Ok Reserved
      else
        Error
          (Invalid_flags (Printf.sprintf "expected flags 0b0010, got %d" flags))
  | Packet_type.CONNECT | Packet_type.CONNACK | Packet_type.PUBACK
  | Packet_type.PUBREC | Packet_type.PUBCOMP | Packet_type.SUBACK
  | Packet_type.UNSUBACK | Packet_type.PINGREQ | Packet_type.PINGRESP
  | Packet_type.DISCONNECT ->
      if flags = 0b0000 then Ok Reserved
      else
        Error
          (Invalid_flags (Printf.sprintf "expected flags 0b0000, got %d" flags))
  | Packet_type.RESERVED ->
      Error (Invalid_flags "RESERVED is not a valid packet type")
