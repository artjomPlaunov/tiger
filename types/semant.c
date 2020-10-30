#include <stddef.h>
#include <stdio.h>
#include <string.h>
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
            return expTy(NULL, Ty_Void());
        }

        case A_fieldVar: {
            struct expty e = transVar(venv, tenv, v->u.field.var);
            Ty_fieldList fl = e.ty->u.record;

            while (fl) { 
                if (strcmp(S_name(fl->head->name),S_name(v->u.field.sym))==0) {
                    return expTy(NULL, fl->head->ty);
                } else {
                    fl = fl->tail;
                }
            }

            EM_error(v->pos,
            "field identifier %s does not match any fields in defined record\
type",
            S_name(v->u.field.sym));

            return expTy(NULL, Ty_Void());
        }

        case A_subscriptVar: {
            struct expty var = transVar(venv, tenv, v->u.subscript.var);
            Ty_ty arrType = var.ty->u.array;
            
            struct expty e = transExp(venv, tenv, v->u.subscript.exp);
            if (e.ty->kind != Ty_int) {
                EM_error(v->pos,
                "subscript expression in array must be of type INT");
                return expTy(NULL, Ty_Void());
            }
            return expTy(NULL, arrType);
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

        /* TO-DO call expressions */

        /* TO-DO: op expressions */
        case A_opExp: {
            A_oper oper = a->u.op.oper;
            struct expty left = transExp(venv, tenv, a->u.op.left);
            struct expty right = transExp(venv, tenv, a->u.op.right);
        }
       
        /* TO-DO: record expressions */
        case A_recordExp: {
            Ty_ty recType = S_look(tenv, a->u.record.typ);
            if (recType == NULL) {
                EM_error(a->pos,
                "undefined record type %s",
                S_name(a->u.record.typ));
                return expTy(NULL, Ty_Void());
            }
            Ty_fieldList TyFields = recType->u.record;
            A_efieldList AbsynFields = a->u.record.fields;

            while (TyFields && AbsynFields) {
                // Check for equal field names.
                if (AbsynFields->head->name != TyFields->head->name) {
                    EM_error(a->pos,
                    "field name in record expression does not match \
                    field name in record type definition");
                    return expTy(NULL, Ty_Void());
                }
                // Check for equivalent field types.
                struct expty e = transExp(venv, tenv, AbsynFields->head->exp);
                if (!typeMatch(e.ty, TyFields->head->ty)) {
                    EM_error(a->pos,
                    "field initializer in record expression does not match \
                    corresponding type for field %s",
                    S_name(TyFields->head->name));
                    return expTy(NULL, Ty_Void());
                }
                
                TyFields = TyFields->tail;
                AbsynFields = AbsynFields->tail;
            }
            /*  If one is NULL and the other isn't, then the length of 
             *  the lists is different. */
            if ((long)TyFields ^ (long)AbsynFields) {
                EM_error(a->pos,
                "Number of fields in record expression does not match \
                number in record type definition");
                return expTy(NULL, Ty_Void());
            
             }
            return expTy(NULL, S_look(tenv, a->u.record.typ));
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
                return expTy(NULL, actual_ty(then.ty));
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
            return expTy(NULL, Ty_Void());
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

        case A_arrayExp: {
            struct expty res = expTy(NULL, Ty_Void());
            Ty_ty arrType = S_look(tenv, a->u.array.typ);
            if (arrType == NULL || arrType->kind != Ty_array) {
                EM_error(a->pos,
                "undefined array type %s",
                S_name(a->u.array.typ));
                return res;
            }
            struct expty size = transExp(venv, tenv, a->u.array.size);
            if (size.ty->kind != Ty_int) {
                EM_error(a->pos,
                "array size expression must be type INT");
                return res;
            }
            struct expty init = transExp(venv, tenv, a->u.array.init);
            if (!typeMatch(init.ty,arrType->u.array)) {
                EM_error(a->pos,
                "init expression incompatible with array type");
                return res;
            }

            res.ty = S_look(tenv,a->u.array.typ);
            return res;
        }
    }
    assert(0);
}

void transDec(S_table venv, S_table tenv, A_dec d) {
    switch (d->kind) {

        case A_functionDec: {
            
        
        }

        case A_varDec: {
            struct expty e = transExp(venv, tenv, d->u.var.init);
            // If constraint type is present
            if (d->u.var.typ != NULL) {
                // Check if constraint is defined
                Ty_ty constraint = S_look(tenv, d->u.var.typ);
                if (constraint == NULL) {
                    EM_error(d->pos, "undefined constraint type");
                    return;
                // Check if constraint is record type in case of NIL init.
                } else if (typeMatch(e.ty, Ty_Nil())) {
                    if (actual_ty(constraint)->kind != Ty_record) {
                        EM_error(d->pos, "non-record constraint type for NIL");
                        return; 
                    } else {
                        S_enter(venv, d->u.var.var, constraint);
                        return;
                    }
                // Check if constraint matches expression type
                } else {
                    if (!typeMatch(e.ty, (Ty_ty)S_look(tenv, d->u.var.typ))) {
                        EM_error(d->pos, "incompatible type constraint");
                        return; 
                    }
                }
            } 
            S_enter(venv, d->u.var.var, E_VarEntry(e.ty));
            return;
        }
        case A_typeDec: {
            A_nametyList hd = d->u.type;
            while (hd != NULL) {
                Ty_ty res = transTy(tenv, hd->head->ty);
                if (res->kind != Ty_void) {
                    S_enter(tenv, hd->head->name, 
                            transTy(tenv, hd->head->ty));
                }
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
        case A_arrayTy: {
            if (S_look(tenv, a->u.array) == NULL) {
                EM_error(a->pos,
                "undefined array type name %s",
                S_name(a->u.array));
                return Ty_Void();
            }
            return Ty_Array(S_look(tenv, a->u.array));
        }
    }
}



