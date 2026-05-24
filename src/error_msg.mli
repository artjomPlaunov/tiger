val any_errors : bool ref
val file_name : string ref
val line_num : int ref
val line_pos : int list ref

exception Error

val reset : ?filename:string -> unit -> unit
val location : int -> string
val error : int -> string -> unit
val impossible : string -> 'a
