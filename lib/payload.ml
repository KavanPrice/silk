type subscribe_topic_filter = string * Flags.qos
type suback_return_code = Success of Flags.qos | Failure

type connect_will = {
  topic : string;
  message : string;
  qos : Flags.qos;
  retain : bool;
}

type connect_payload = {
  client_id : string;
  will : connect_will option;
  username : string option;
  password : string option;
}

type payload =
  | Connect_payload of connect_payload
  | Publish_payload of string option
  | Subscribe_payload of subscribe_topic_filter list
  | Suback_payload of suback_return_code list
  | Unsubscribe_payload of string list
  | No_payload
