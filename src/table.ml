module type TABLE = sig
  type key
  type 'a table

  val empty : 'a table
  val enter : 'a table * key * 'a -> 'a table
  val look : 'a table * key -> 'a option
end

module IntMapTable (Key : sig
  type t

  val get_int : t -> int
end) : TABLE with type key = Key.t = struct
  module IntMap = Map.Make (Int)

  type key = Key.t
  type 'a table = 'a IntMap.t

  let empty = IntMap.empty
  let enter (table, key, value) = IntMap.add (Key.get_int key) value table
  let look (table, key) = IntMap.find_opt (Key.get_int key) table
end
