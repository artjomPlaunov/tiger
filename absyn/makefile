P       := exe
OBJECTS = parsetest.o absyn.o lex.yy.o parse.o prabsyn.o symbol.o \
          table.o tiger.tab.o util.o errormsg.o
CFLAGS = -g -std=gnu11
CC     = gcc

$(P): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $(OBJECTS) $(LDLIBS)

parsetest.o: parsetest.c parse.h errormsg.h util.h absyn.h symbol.h \
                prabsyn.h
	$(CC) $(CFLAGS) -c -o $@ $*.c

symbol.o: symbol.c util.h
	$(CC) $(CFLAGS) -c -o $@ $*.c

absyn.o: absyn.c util.h symbol.h
	$(CC) $(CFLAGS) -c -o $@ $*.c

table.o: table.h util.h
	$(CC) $(CFLAGS) -c -o $@ $*.c

parse.o: parse.c 
	$(CC) $(CFLAGS) -c -o $@ $*.c

tiger.tab.o: tiger.tab.c absyn.h symbol.h
	$(CC) $(CFLAGS) -c -o $@ $*.c

tiger.tab.c: tiger.y
	bison -dv tiger.y

tiger.tab.h: tiger.tab.c
	echo "y.tab.h was created at the same time as y.tab.c"

errormsg.o: errormsg.c errormsg.h util.h
	$(CC) $(CFLAGS) -c -o $@ $*.c

lex.yy.o: lex.yy.c tiger.tab.h errormsg.h util.h absyn.h symbol.h
	$(CC) $(CFLAGS) -c -o $@ $*.c

lex.yy.c: tiger.lex
	lex tiger.lex

util.o: util.c util.h
	$(CC) $(CFLAGS) -c -o $@ $*.c

clean: 
	rm $(OBJECTS) $(P1) tiger.tab.h lex.yy.c tiger.tab.c exe tiger.output
