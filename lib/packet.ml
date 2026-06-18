type fixed_header = {
  packet_type : Packet_type.packet_type;
  flags : Flags.fixed_header_flags;
}

type packet_identifier = int
type variable_header = packet_identifier option
type payload = string option

type packet = {
  fixed_header : fixed_header;
  variable_header : variable_header;
  payload : payload;
}
