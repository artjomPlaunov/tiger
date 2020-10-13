#ifndef SEMANT_H_
#define SEMANT_H_

#include "absyn.h"
#include "symbol.h"
#include "translate.h"
#include "types.h"

struct  expty {Tr_exp exp; Ty_ty ty;};
struct  expty expTy(Tr_exp exp, Ty_ty ty);

void    SEM_transProg(A_exp exp);

struct  expty   transVar(S_table venv,  S_table tenv,   A_var v);
struct  expty   transExp(S_table venv,  S_table tenv,   A_exp a);
void            transDec(S_table venv,  S_table tenv,   A_dec d);
Ty_ty           transTy(                S_table tenv,   A_ty a);

#endif
