type packet_type_parse_error =
  | Invalid_type_value_int of int
  | Invalid_type_value_string of string
  | Invalid_length of string

type parse_error = Type_error of packet_type_parse_error | Other of string

type packet_type =
  | RESERVED
  | CONNECT
  | CONNACK
  | PUBLISH
  | PUBACK
  | PUBREC
  | PUBREL
  | PUBCOMP
  | SUBSCRIBE
  | SUBACK
  | UNSUBSCRIBE
  | UNSUBACK
  | PINGREQ
  | PINGRESP
  | DISCONNECT

let packet_type_of_int (type_val : int) =
  match type_val with
  | 0 | 15 -> Ok RESERVED
  | 1 -> Ok CONNECT
  | 2 -> Ok CONNACK
  | 3 -> Ok PUBLISH
  | 4 -> Ok PUBACK
  | 5 -> Ok PUBREC
  | 6 -> Ok PUBREL
  | 7 -> Ok PUBCOMP
  | 8 -> Ok SUBSCRIBE
  | 9 -> Ok SUBACK
  | 10 -> Ok UNSUBSCRIBE
  | 11 -> Ok UNSUBACK
  | 12 -> Ok PINGREQ
  | 13 -> Ok PINGRESP
  | 14 -> Ok DISCONNECT
  | n -> Error (Invalid_type_value_int n)

let packet_type_of_string (type_val : string) =
  match String.lowercase_ascii type_val with
  | "0" | "reserved" -> Ok RESERVED
  | "1" | "connect" -> Ok CONNECT
  | "2" | "connack" -> Ok CONNACK
  | "3" | "publish" -> Ok PUBLISH
  | "4" | "puback" -> Ok PUBACK
  | "5" | "pubrec" -> Ok PUBREC
  | "6" | "pubrel" -> Ok PUBREL
  | "7" | "pubcomp" -> Ok PUBCOMP
  | "8" | "subscribe" -> Ok SUBSCRIBE
  | "9" | "suback" -> Ok SUBACK
  | "10" | "unsubscribe" -> Ok UNSUBSCRIBE
  | "11" | "unsuback" -> Ok UNSUBACK
  | "12" | "pingreq" -> Ok PINGREQ
  | "13" | "pingresp" -> Ok PINGRESP
  | "14" | "disconnect" -> Ok DISCONNECT
  | other -> Error (Invalid_type_value_string other)
