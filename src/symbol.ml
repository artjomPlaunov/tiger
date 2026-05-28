type t = {
  name : string;
  id : int;
}

let nextsym = ref 0
let size_hint = 128
let hashtable : (string, int) Hashtbl.t = Hashtbl.create size_hint

let symbol name =
  match Hashtbl.find_opt hashtable name with
  | Some id -> { name; id }
  | None ->
      let id = !nextsym in
      incr nextsym;
      Hashtbl.add hashtable name id;
      { name; id }

let name symbol = symbol.name

module SymbolTable = Table.IntMapTable (struct
  type nonrec t = t

  let get_int symbol = symbol.id
end)

type 'a table = 'a SymbolTable.table

let empty = SymbolTable.empty
let enter = SymbolTable.enter
let look = SymbolTable.look
