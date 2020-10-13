#include <stdio.h>
#include <stdlib.h>

#include "absyn.h"
#include "errormsg.h"
#include "parse.h"
#include "prabsyn.h"
#include "semant.h"
#include "symbol.h"
#include "util.h"

int main(int argc, char **argv) {
    if (argc!=2) {fprintf(stderr,"usage: a.out filename\n"); exit(1);}
    A_exp root = parse(argv[1]);
    if (root) printf("%s:parse successful.\n", argv[1]);

    if (root) {
        pr_exp(stdout, root, 0); 
        printf("\n");
        SEM_transProg(root); 
    }
    return 0;
}
