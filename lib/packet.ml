type fixed_header = {
  packet_type : Packet_type.packet_type;
  flags : Flags.fixed_header_flags;
}

type variable_header = string
type payload = string

type packet = {
  fixed_header : fixed_header;
  variable_header : variable_header;
  payload : payload;
}
