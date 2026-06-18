type fixed_header = {
  packet_type : Packet_type.packet_type;
  flags : Flags.fixed_header_flags;
}

type packet_identifier = int

type variable_header =
  | Connect_header of { keepalive : int; connect_flags : int }
  | Publish_header of { topic : string; packet_id : int option }
  | Packet_id of int
  | No_variable_header

type payload = string option

type packet = {
  fixed_header : fixed_header;
  variable_header : variable_header;
  payload : payload;
}
