#include "env.h"
#include "util.h"


E_enventry E_VarEntry(Ty_ty ty) {
    E_enventry e = checked_malloc(sizeof(*e));
    e->kind = E_varEntry;
    e->u.var.ty = ty;
    return e;
}

E_enventry E_FunEntry(Ty_tyList formals, Ty_ty result) {return 0;}

S_table E_base_tenv(void) {
    S_table s = S_empty();
    S_beginScope(s);
    S_symbol intSym = S_Symbol(String("int"));
    S_symbol stringSym = S_Symbol(String("string"));
    S_enter(s, intSym, Ty_Int());
    S_enter(s, stringSym, Ty_String());
    return s;
}

S_table E_base_venv(void) { 
    S_table s = S_empty();
    S_beginScope(s);
    return s;
}
