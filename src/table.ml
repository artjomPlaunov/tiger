module type TABLE = sig
  type key
  type 'a table

  val empty : 'a table
  val enter : key -> 'a -> 'a table -> 'a table
  val look : key -> 'a table -> 'a option
end

module IntMapTable (Key : sig
  type t

  val get_int : t -> int
end) : TABLE with type key = Key.t = struct
  module IntMap = Map.Make (Int)

  type key = Key.t
  type 'a table = 'a IntMap.t

  let empty = IntMap.empty
  let enter key value table = IntMap.add (Key.get_int key) value table
  let look key table = IntMap.find_opt (Key.get_int key) table
end
