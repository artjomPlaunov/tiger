type t

val of_string : string -> t
val to_string : t -> string

type 'a table

val empty : 'a table
val enter : 'a table * t * 'a -> 'a table
val look : 'a table * t -> 'a option
