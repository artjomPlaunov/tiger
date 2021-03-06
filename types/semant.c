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

static int loopCount = 0;

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
                return expTy(NULL, (x->u.var.ty));
            } else {
                EM_error(v->pos, "undefined variable %s",
                            S_name(v->u.simple));
            }
            return expTy(NULL, Ty_Void());
        }

        case A_fieldVar: {
            struct expty e = transVar(venv, tenv, v->u.field.var);

            if (e.ty->kind != Ty_record) {
                EM_error(v->pos,
                "non-record variable type in field expression");
                return expTy(NULL, Ty_Void());
            }

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
            if (var.ty->kind != Ty_array) {
                EM_error(v->pos,
                "subscript variable not array type");
                return expTy(NULL, Ty_Void());
            }

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
        case A_callExp: {
            E_enventry e = S_look(venv, a->u.call.func);
            if (e == NULL ) {
                EM_error(a->pos,
                "call to undeclared function");
                return expTy(NULL, NULL);
            }
            A_expList args = a->u.call.args;
            Ty_tyList formals = e->u.fun.formals;
            Ty_ty result_type = e->u.fun.result;
            if (result_type == NULL) {
                result_type = Ty_Void();
            }

            while (args && formals) {
                
                A_exp arg = args->head;
                Ty_ty formal = formals->head;

                struct expty e = transExp(venv, tenv, arg);
                if (!typeMatch(e.ty, formal)) {
                    EM_error(a->pos,
                    "function argument type mismatch to signature");
                    return expTy(NULL, result_type);
                }

                args = args->tail;
                formals = formals->tail;
            }
            if (args || formals) {
                if (args) {
                    EM_error(a->pos,
                    "too many arguments passed to function call");
                } else {
                    EM_error(a->pos,
                    "too few arguments passed to function call");
                }
                return expTy(NULL, result_type);
            }

            

            return expTy(NULL, result_type);
        }

        /* TO-DO: op expressions */
        case A_opExp: {
            
            // This code is an utter mess. 
            // Refactor redundant logic. 
            A_oper oper = a->u.op.oper;
            struct expty left = transExp(venv, tenv, a->u.op.left);
            struct expty right = transExp(venv, tenv, a->u.op.right);
           
            // Handle nil assignment to record types.
            if (oper == A_eqOp || oper == A_neqOp) {
                if (left.ty->kind == Ty_record && right.ty->kind == Ty_nil) {
                    return expTy(NULL, Ty_Int());
                }
            }

            if (    oper == A_plusOp 
                ||  oper == A_minusOp 
                ||  oper == A_timesOp
                ||  oper == A_divideOp 
                ||  oper == A_andOp
                ||  oper == A_orOp) {
            
                if (left.ty->kind != Ty_int) {
                    EM_error(a->pos,
                    "left operand supposed to be of type int");
                } else if (right.ty->kind != Ty_int) {
                    EM_error(a->pos,
                    "right operand supposed to be of type int");
                }
            } else if (oper == A_eqOp || oper == A_neqOp) {
                if (    left.ty->kind == Ty_record  ||
                        right.ty->kind == Ty_record ||
                        left.ty->kind == Ty_array   ||
                        right.ty->kind == Ty_array ) {
                    
                    if (!typeMatch(left.ty, right.ty)) {
                        EM_error(a->pos,
                        "record or array comparison type mismatch");    
                    }
                } else if ( left.ty->kind == Ty_int     ||
                            right.ty->kind == Ty_int    ||
                            left.ty->kind == Ty_string  ||
                            right.ty->kind == Ty_string ) {
                    if (!typeMatch(left.ty, right.ty)) {
                        EM_error(a->pos,
                        "comparison type mismatch");
                    }
                } else {
                    EM_error(a->pos,
                    "invalid comparison type");
                }
            } else if ( left.ty->kind == Ty_int     ||
                        right.ty->kind == Ty_int    ||
                        left.ty->kind == Ty_string  ||
                        right.ty->kind == Ty_string) {
                if (!typeMatch(left.ty, right.ty)) {
                    EM_error(a->pos,
                    "operator type mismatch");
                }
            } else {
                EM_error(a->pos,
                "invalid operator type");
            }
            return expTy(NULL, Ty_Int());
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
                if (actual_ty(TyFields->head->ty)->kind == Ty_record &&
                    e.ty->kind == Ty_nil ) {
                    ; // OK nil assignment to record type.
                } else if (!typeMatch(e.ty, TyFields->head->ty)) {
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
           
            if ((actual_ty(e1.ty)->kind == Ty_record) 
                && e2.ty->kind == Ty_nil) {
                ; // OK 
            } else if ( !typeMatch(e1.ty, e2.ty) ) {
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
                
				loopCount++;
				struct expty body = transExp(venv, tenv, a->u.while_.body);
                loopCount--;
				
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
            loopCount++;
			struct expty body = transExp(venv, tenv, a->u.for_.body);
            loopCount--;
			if (body.ty->kind != Ty_void) {
                EM_error(a->u.for_.body->pos,
                "for loop body must not produce a value");
            }
            // End scope for loop iterator.
            S_endScope(venv);
            return expTy(NULL, Ty_Void());
        }
   
        case A_breakExp: {
            if (loopCount == 0) {
				EM_error(a->pos,
				"break statement found outside of loop");
			}
			return expTy(NULL, Ty_Void());
        }

        case A_letExp: {
            struct expty exp;
            A_decList d;
            S_beginScope(venv);
            S_beginScope(tenv);
            for (d = a->u.let.decs; d; d=d->tail) {
                transDec(venv, tenv, d->head);
            }
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
           
            S_table functionDecs = S_empty();

            // First Pass: gather function headers.
            A_fundecList lst = d->u.function;            
            while (lst) { 
                A_fundec head = lst->head;
                if (S_look(functionDecs, head->name)) {
                    EM_error(d->pos,
                    "mutually recursive function redeclaration");
                    lst = lst->tail;
                    continue;
                }
                A_fieldList params = head->params;
                Ty_tyList res = Ty_TyList(NULL,NULL); 
                Ty_tyList cur = res;

                while (params) {
                    // Just collect the type on first pass, do not enter 
                    // variable into environment. 
                    A_field field = params->head;
                    Ty_ty param = S_look(tenv, field->typ);
                    if (!param) {
                        EM_error(d->pos, "undefined parameter type");
                        return;
                    } else {
                        cur->tail = Ty_TyList(param, NULL);
                        cur = cur->tail;
                    }
                    params = params->tail;
                }
                // Process function result type.
                Ty_ty constraint = NULL;
                if (head->result) {
                    constraint = S_look(tenv, head->result);
                    if (!constraint) {
                        EM_error(d->pos, "undefined function result type");
                        return;
                    }
                }
                // Add function to variable scope.
                S_enter(functionDecs, head->name, 
                        E_FunEntry(res->tail, constraint));
                lst = lst->tail;
            }
            S_move(venv, functionDecs);


            // Second pass: process function bodies, patch parameters.
            lst = d->u.function;
            escape: while (lst) {
                A_fundec head = lst->head;
                
                // Process function parameter list.
                A_fieldList params = head->params;   
                
                S_beginScope(venv);

                while (params) {
                    A_field field = params->head;
                    Ty_ty param = S_look(tenv, field->typ);
                    S_enter(venv, field->name, E_VarEntry(param));
                    params = params->tail; 
                }
                
                Ty_ty constraint = NULL;
                if (head->result) {
                    constraint = S_look(tenv, head->result);
                }
               
                // Process function expression.
                struct expty e = transExp(venv, tenv, head->body);
                
                if (constraint) {
                    if (!typeMatch(constraint, e.ty)) {
                        EM_error(d->pos, 
                        "function return type and expression body mismatch");
                        S_endScope(venv);
                        lst = lst->tail;
                        goto escape;
                    }
                } else {
                    if (e.ty != Ty_Void()) {
                        EM_error(d->pos,
                        "procedure returning value");
                        S_endScope(venv);
                        lst = lst->tail;
                        goto escape;
                    }
                }
                S_endScope(venv);
                lst = lst->tail;
            }
            return;
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
                        S_enter(venv, d->u.var.var, E_VarEntry(constraint));
                        return;
                    }
                // Check if constraint matches expression type
                } else {
                    if (!typeMatch(e.ty, (Ty_ty)S_look(tenv, d->u.var.typ))) {
                        EM_error(d->pos, "incompatible type constraint");
                        return; 
                    }
                }
            } else {
                // If constraint type is not present and initializer is of 
                // type NIL, throw an error.
                if (e.ty->kind == Ty_nil) {
                    EM_error(d->pos,
                    "no constraint type for nil initializer");
                    return;
                }
            }
            S_enter(venv, d->u.var.var, E_VarEntry(e.ty));
            return;
        }
        // TO-DO: Check for illegal cycles in type declarations.
        case A_typeDec: {
            // First pass: create header environment ' e '.
            A_nametyList hd = d->u.type;

            S_table typeDecs = S_empty();

            while (hd != NULL) {
                S_symbol header = hd->head->name;
                if (S_look(typeDecs, header)) {
                    EM_error(d->pos,
                    "mutually recursive type re-declaration");
                    hd = hd->tail;
                    continue;
                }
                S_enter(typeDecs, header, Ty_Name(header,NULL));
                hd = hd->tail;
            }
            S_move(tenv, typeDecs);

            // Second pass: Process bodies in environment ' e '.
            hd = d->u.type;
            while (hd != NULL) {
                Ty_ty res = transTy(tenv, hd->head->ty);
                if (res->kind != Ty_void) {
                    // Patch over NULL Ty_Name's.
                    Ty_ty patch = S_look(tenv, hd->head->name);
                    if (patch->kind == Ty_name) {
                        patch->u.name.ty = res;
                        S_enter(tenv, hd->head->name, res);
                    } else {
                        S_enter(tenv, hd->head->name, res);
                    }
                }
                hd = hd->tail;
            }
        
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
                return (S_look(tenv, a->u.name));
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



