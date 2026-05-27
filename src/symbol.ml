type t = string

let symbol name = name
let name symbol = symbol

module Table = Map.Make (String)

