type fixed_header = {
  packet_type : Packet_type.packet_type;
  flags : Flags.fixed_header_flags;
  remaining_length : int;
}

type variable_header =
  | Connect_header of { keepalive : int; connect_flags : int }
  | Publish_header of { topic : string; packet_id : int option }
  | Packet_id of int
  | No_variable_header

type packet = {
  fixed_header : fixed_header;
  variable_header : variable_header;
  payload : Payload.payload;
}
