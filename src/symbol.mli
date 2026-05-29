type t

val of_string : string -> t
val to_string : t -> string

type 'a table

val empty : 'a table
val enter : t -> 'a -> 'a table -> 'a table
val look : t -> 'a table -> 'a option
