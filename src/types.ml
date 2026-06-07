type unique = unit ref

type ty =
  | Record of (Symbol.t * ty) list * unique
  | Nil
  | Int
  | String
  | Array of ty * unique
  | Name of Symbol.t * ty option ref
  | Unit
  | Error

let rec actual ty =
  match ty with
  | Name (_, ty_ref) -> (
      match !ty_ref with
      | Some ty -> actual ty
      | None -> ty)
  | ty -> ty

let equal left_ty right_ty =
  match (actual left_ty, actual right_ty) with
  | Error, _
  | _, Error ->
      true
  | Int, Int
  | String, String
  | Unit, Unit
  | Nil, Nil ->
      true
  | Record (_, left_unique), Record (_, right_unique) -> left_unique == right_unique
  | Array (_, left_unique), Array (_, right_unique) -> left_unique == right_unique
  | _ -> false

let compatible left_ty right_ty =
  match (actual left_ty, actual right_ty) with
  | Error, _
  | _, Error ->
      true
  | Nil, Record _
  | Record _, Nil ->
      true
  | left_ty, right_ty -> equal left_ty right_ty
