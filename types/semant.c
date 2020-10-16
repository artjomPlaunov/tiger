#include <stddef.h>
#include <stdio.h>
#include "semant.h"
#include "env.h"
#include "errormsg.h"

struct expty expTy(Tr_exp exp, Ty_ty ty) {
    struct expty e; e.exp=exp; e.ty=ty; return e;    
}

void SEM_transProg(A_exp exp) {
    S_table tenv = E_base_tenv();
    S_table venv = E_base_venv();
    struct expty expty = transExp(venv, tenv, exp);
}

static int typeMatch(Ty_ty t1, Ty_ty t2) {
    if (t1->kind == t2->kind) {
        // If record or array type, check for pointer equality. 
        if (t1->kind == Ty_record || t1->kind == Ty_array) {
            if (t1 == t2) 
                return 1;
            else
                return 0;
        } else 
            return 1;
    } else {
        return 0;
    }
}

static Ty_ty actual_ty(Ty_ty t) {
    if (t->kind == Ty_name) {
        return actual_ty(t->u.name.ty);
    } else {
        return t;
    }
}

struct  expty   transVar(S_table venv,  S_table tenv,   A_var v) {
    switch (v->kind) {
        case A_simpleVar: {
            E_enventry x = S_look(venv, v->u.simple);
            if (x && x->kind==E_varEntry) {
                return expTy(NULL, actual_ty(x->u.var.ty));
            } else {
                EM_error(v->pos, "undefined variable %s",
                            S_name(v->u.simple));
            }
            /*  Dummy return to allow the type checker to continue. 
                Set variable to be type VOID; not sure if this is the best
                solution? Need to think this through and see how it 
                interacts with other components of the type checker. */
            return expTy(NULL, Ty_Void());
        }
    }
}

struct expty transExp(S_table venv, S_table tenv, A_exp a) {
    switch (a->kind) {
        case A_varExp:
            return transVar(venv, tenv, a->u.var);
        case A_nilExp:
            return expTy(NULL, Ty_Nil());
        case A_intExp:
            return expTy(NULL, Ty_Int());
        case A_stringExp:
            return expTy(NULL, Ty_String());

        /* TO-DO: op expressions */
        case A_opExp: {
            A_oper oper = a->u.op.oper;
            struct expty left = transExp(venv, tenv, a->u.op.left);
            struct expty right = transExp(venv, tenv, a->u.op.right);
        }
       
        /* TO-DO: record expressions */
        case A_recordExp: {
        }

        case A_seqExp: {
            struct expty e = expTy(NULL, Ty_Void());
            A_expList hd = a->u.seq;
            while (hd != NULL) {
                e = transExp(venv, tenv, hd->head);
                hd = hd->tail;
            }
            return e;
        }

        case A_assignExp: {
            struct expty e1 = transVar(venv, tenv, a->u.assign.var);
            struct expty e2 = transExp(venv, tenv, a->u.assign.exp);
            if (e1.ty->kind != e2.ty->kind) {
                EM_error(a->pos, "Incompatible types for assignment");
            }
            return expTy(NULL, Ty_Void());
        }

        case A_ifExp: {
            if (a->u.if_.else_) {
                struct expty test = transExp(venv, tenv, a->u.if_.test);
                if (test.ty->kind != Ty_int) {
                    EM_error(a->pos, "test clause in if expr must be ty INT");
                }
                struct expty then = transExp(venv, tenv, a->u.if_.then);
                struct expty else_ = transExp(venv, tenv, a->u.if_.else_);
                if (then.ty->kind != else_.ty->kind) {
                    EM_error(a->pos,
                    "incompatible types in then and else clauses");
                }
                return expTy(NULL, then.ty);
            } else {
                struct expty test = transExp(venv, tenv, a->u.if_.test);
                if (test.ty->kind != Ty_int) {
                    EM_error(a->pos, "test clause in if expr must be ty INT");
                }
                struct expty then = transExp(venv, tenv, a->u.if_.then);
                if (then.ty->kind != Ty_void) {
                    EM_error(a->pos, 
                    "then type in if-then must produce no value");
                }
                return expTy(NULL, Ty_Void());
            }
        }

        case A_whileExp: {
            struct expty test = transExp(venv, tenv, a->u.while_.test);
                if (test.ty->kind != Ty_int) {
                    EM_error(a->pos, 
                    "test clause in while expr must be ty INT");
                }
                struct expty body = transExp(venv, tenv, a->u.while_.body);
                if (body.ty->kind != Ty_void) {
                    EM_error(a->pos, 
                    "type of body in while expr must produce no value");
                }
                return expTy(NULL, Ty_Void());
        }

        /*  TO-DO: 
         *      Tiger specs state that the variable initialized as the 
         *      iterator in the for loop may not be assigned to; 
         *      As of yet this is not enforced. */
        case A_forExp: {
            struct expty lo = transExp(venv, tenv, a->u.for_.lo);
            struct expty hi = transExp(venv, tenv, a->u.for_.hi);
            if (hi.ty->kind != Ty_int || lo.ty->kind != Ty_int) {
                EM_error(a->pos,
                "initializer and limit expressions must be type INT in for");
                return expTy(NULL, Ty_Void());
            }
            // Begin new scope for for loop iterator. 
            S_beginScope(venv);
            S_enter(venv, a->u.for_.var, E_VarEntry(Ty_Int()));
            struct expty body = transExp(venv, tenv, a->u.for_.body);
            if (body.ty->kind != Ty_void) {
                EM_error(a->u.for_.body->pos,
                "for loop body must not produce a value");
            }
            // End scope for loop iterator.
            S_endScope(venv);
        }
   
        /* TO-DO: check that break expressions are within for or while 
            loops. */
        case A_breakExp: {
            return expTy(NULL, Ty_Void());
        }

        case A_letExp: {
            struct expty exp;
            A_decList d;
            S_beginScope(venv);
            S_beginScope(tenv);
            for (d = a->u.let.decs; d; d=d->tail)
                transDec(venv, tenv, d->head);
            exp = transExp(venv, tenv, a->u.let.body);
            S_endScope(tenv);
            S_endScope(venv);
            return exp;
        }

        /* TO-DO - array expressions */
        case A_arrayExp: {

        }
    }
    assert(0);
}

void transDec(S_table venv, S_table tenv, A_dec d) {
    switch (d->kind) {
        case A_varDec: {
            struct expty e = transExp(venv, tenv, d->u.var.init);
            
            // If constraint type is present
            if (d->u.var.typ != NULL) {
                // Check if constraint is defined
                Ty_ty constraint = S_look(tenv, d->u.var.typ);
                if (constraint == NULL) {
                    EM_error(d->pos, "undefined constraint type");
                // Check if constraint is record type in case of NIL init.
                } else if (typeMatch(e.ty, Ty_Nil())) {
                    // FIX THIS CONDIITON CHECK ONCE RECORD TYDECS ARE DEFINED
        
                    if (actual_ty(constraint)->kind != Ty_record) {
                        EM_error(d->pos, "non-record constraint type for NIL");
                    } else {
                        S_enter(venv, d->u.var.var, constraint);
                    }
                // Check if constraint matches expression type
                } else {
                    if (!typeMatch(e.ty, (Ty_ty)S_look(tenv, d->u.var.typ))) {
                        EM_error(d->pos, "incompatible type constraint");
                    }
                }
            } 
            S_enter(venv, d->u.var.var, E_VarEntry(e.ty));
            break;
        }
        case A_typeDec: {
            A_nametyList hd = d->u.type;
            while (hd != NULL) {
                S_enter(tenv, hd->head->name, 
                        transTy(tenv, hd->head->ty));
                hd = hd->tail;
            }
            break;
        }    
    }
}

Ty_ty transTy(S_table tenv, A_ty a) {
    switch (a->kind) {    
        case A_nameTy: {
            if (S_look(tenv, a->u.name) == NULL) {
                EM_error(a->pos, "undefined type name: %s",
                            S_name(a->u.name));
                return Ty_Void();
            } else {
                return actual_ty(S_look(tenv, a->u.name));
            }
        }
        case A_recordTy: {
            Ty_fieldList res = Ty_FieldList(NULL,NULL);
            Ty_fieldList cur = res;
            
            for (A_fieldList hd = a->u.record; hd != NULL; hd = hd->tail) {
                Ty_ty fieldType = S_look(tenv, hd->head->typ);
                if (fieldType == NULL) {
                    EM_error(a->pos, "undefined field type: %s",
                                        S_name(hd->head->typ));
                } else {
                    Ty_field new_hd = Ty_Field(hd->head->name, fieldType);
                    cur->tail = Ty_FieldList(new_hd, NULL);
                    cur = cur->tail;
                }
            }
            return Ty_Record(res->tail);
        }
    }
}
