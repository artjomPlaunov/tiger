/* A Bison parser, made by GNU Bison 3.0.5.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.5"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 1 "tiger.y" /* yacc.c:339  */

#include <stdio.h>
#include <stdlib.h>
#include "absyn.h"
#include "util.h"
#include "symbol.h"
#include "errormsg.h"

int yylex(void); /* function prototype */

A_exp absyn_root;

void yyerror(char *s)
{
        EM_error(EM_tokPos, "%s", s);
}

#line 84 "tiger.tab.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "tiger.tab.h".  */
#ifndef YY_YY_TIGER_TAB_H_INCLUDED
# define YY_YY_TIGER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ID = 258,
    STRING = 259,
    INT = 260,
    COMMA = 261,
    COLON = 262,
    SEMICOLON = 263,
    LPAREN = 264,
    RPAREN = 265,
    LBRACK = 266,
    RBRACK = 267,
    LBRACE = 268,
    RBRACE = 269,
    DOT = 270,
    PLUS = 271,
    MINUS = 272,
    TIMES = 273,
    DIVIDE = 274,
    EQ = 275,
    NEQ = 276,
    LT = 277,
    GT = 278,
    LE = 279,
    GE = 280,
    AND = 281,
    OR = 282,
    ASSIGN = 283,
    ARRAY = 284,
    IF = 285,
    THEN = 286,
    ELSE = 287,
    WHILE = 288,
    FOR = 289,
    TO = 290,
    DO = 291,
    LET = 292,
    IN = 293,
    END = 294,
    OF = 295,
    BREAK = 296,
    NIL = 297,
    FUNCTION = 298,
    VAR = 299,
    TYPE = 300,
    UMINUS = 301
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 20 "tiger.y" /* yacc.c:355  */

    int             ival;
    char *          sval;
    A_exp           exp;
    A_var           var;
    A_pos           pos;
    A_expList       arg_lst;
    A_expList       exp_lst;
    A_efield        efield;
    A_efieldList    efield_lst;
    A_decList       dec_lst;
    A_dec           dec;
    A_ty            ty;
    A_nametyList    namety_lst;
    A_namety        namety;
    A_field         field;
    A_fieldList     field_lst;
    A_fundecList    fun_dec_lst;
    A_fundec        fun_dec;
    

#line 193 "tiger.tab.c" /* yacc.c:355  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_TIGER_TAB_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 210 "tiger.tab.c" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  30
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   359

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  47
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  21
/* YYNRULES -- Number of rules.  */
#define YYNRULES  70
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  175

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   301

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    90,    90,    92,    94,    97,   102,   105,   110,   113,
     116,   119,   124,   127,   132,   135,   138,   141,   154,   157,
     162,   167,   170,   173,   176,   181,   184,   189,   194,   198,
     201,   205,   208,   211,   214,   217,   220,   223,   226,   229,
     232,   235,   238,   241,   244,   247,   250,   253,   257,   260,
     263,   266,   270,   279,   282,   285,   288,   291,   294,   297,
     302,   305,   310,   313,   318,   321,   326,   329,   334,   339,
     342
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "ID", "STRING", "INT", "COMMA", "COLON",
  "SEMICOLON", "LPAREN", "RPAREN", "LBRACK", "RBRACK", "LBRACE", "RBRACE",
  "DOT", "PLUS", "MINUS", "TIMES", "DIVIDE", "EQ", "NEQ", "LT", "GT", "LE",
  "GE", "AND", "OR", "ASSIGN", "ARRAY", "IF", "THEN", "ELSE", "WHILE",
  "FOR", "TO", "DO", "LET", "IN", "END", "OF", "BREAK", "NIL", "FUNCTION",
  "VAR", "TYPE", "UMINUS", "$accept", "program", "pos", "decs", "dec_lst",
  "dec", "fun_dec_lst", "fun_dec", "namety_lst", "namety", "ty",
  "field_lst", "field", "l_val", "exp", "seq_exp", "exp_lst", "fun_call",
  "arg_lst", "efield", "efield_lst", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301
};
# endif

#define YYPACT_NINF -123

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-123)))

#define YYTABLE_NINF -4

#define yytable_value_is_error(Yytable_value) \
  (!!((Yytable_value) == (-4)))

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
     162,    17,  -123,  -123,  -123,   162,  -123,  -123,  -123,  -123,
    -123,  -123,    25,     4,   312,  -123,  -123,  -123,  -123,  -123,
    -123,  -123,     3,   284,   162,    32,    14,  -123,  -123,   162,
    -123,   162,  -123,  -123,  -123,  -123,  -123,  -123,  -123,  -123,
    -123,  -123,  -123,  -123,  -123,  -123,    51,     6,  -123,   235,
      33,   162,   193,    19,    39,  -123,    45,    12,  -123,    14,
    -123,     9,  -123,     8,  -123,   300,    59,   162,   162,   162,
     162,   162,   162,   162,   162,   162,   162,   162,   162,   162,
    -123,    83,    53,    44,  -123,    60,    66,   162,  -123,   267,
     162,   162,    56,    79,    63,   162,  -123,  -123,  -123,    46,
    -123,   312,    20,    20,  -123,  -123,   324,   324,   324,   324,
     324,   324,   334,   105,   162,  -123,   162,    84,  -123,  -123,
     162,   312,   247,    31,    -5,    -2,    55,    58,  -123,   312,
    -123,   312,   162,    88,    -4,    86,   106,   108,   162,  -123,
       7,    73,  -123,  -123,   162,   214,   112,   114,   162,    -3,
     115,    91,   312,  -123,   119,   131,   312,   162,  -123,   116,
     312,   132,   162,  -123,   162,  -123,  -123,   312,   162,   117,
     312,   312,   312,   162,   312
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     3,     3,     3,     3,     0,     3,     3,     3,     3,
       3,     3,     0,    31,     2,    51,    36,     3,     3,    28,
      34,    33,     0,     0,     0,     0,     4,    58,    32,     0,
       1,     0,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     0,     0,    60,    62,
       0,     0,     0,     0,     0,     3,     0,     0,     5,     6,
      11,    12,     8,    18,    35,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
      64,    66,     0,     0,    49,    69,     0,     0,    61,    55,
       0,     0,     0,     0,     0,     0,     7,    13,    19,    30,
      29,    53,    37,    38,    39,    40,    41,    42,    44,    43,
      46,    45,    47,    48,     0,    65,     0,     0,    50,    63,
       0,    56,     0,     0,     0,     0,     0,     0,    67,    68,
      70,    54,     0,     0,     0,     0,    25,     0,     0,    21,
       0,     0,    20,    59,     0,     0,     0,     0,     0,     0,
       0,     0,     9,    22,     0,     0,    52,     0,    27,     0,
      14,     0,     0,    26,     0,    23,    24,    57,     0,     0,
      15,    10,    16,     0,    17
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -123,  -123,   143,  -123,    80,  -123,    81,  -123,    77,  -123,
    -123,  -122,  -123,  -123,     0,  -123,   -73,  -123,    27,  -123,
      26
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,    12,    19,    57,    58,    59,    60,    61,    62,    63,
     142,   135,   136,    13,    49,    15,    50,    16,    82,    85,
      86
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      14,   139,   137,   147,   161,    23,     1,     2,     3,    83,
     133,   140,     4,    48,   119,    31,   148,   162,   154,    32,
      84,   153,   126,   138,    52,    30,    17,   141,   163,    64,
      18,    65,    33,     5,   133,    53,     6,     7,    36,    37,
       8,   134,    92,    88,     9,    10,    81,    91,    94,    11,
      95,    89,    54,    56,     1,     2,     3,    54,    55,    56,
       4,    80,   100,   115,   116,   123,   117,   101,   102,   103,
     104,   105,   106,   107,   108,   109,   110,   111,   112,   113,
     118,     5,   124,   125,     6,     7,    -3,    83,     8,   114,
     121,   122,     9,    10,   143,   146,   149,    11,   144,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,   151,   150,   155,    81,   158,   129,   159,   133,   164,
     131,    34,    35,    36,    37,    38,    39,    40,    41,    42,
      43,    44,   145,   165,   166,   169,   168,   173,   152,    96,
      98,   128,    97,   130,   156,    20,    21,    22,   160,    24,
      25,    26,    27,    28,    29,     0,     0,   167,     0,     0,
      46,    47,   170,     0,   171,     1,     2,     3,   172,     0,
       0,     4,     0,   174,     0,    66,    67,    68,    69,    70,
      71,    72,    73,    74,    75,    76,    77,    78,    79,     0,
       0,     0,     5,     0,     0,     6,     7,     0,    93,     8,
       0,     0,     0,     9,    10,     0,     0,     0,    11,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,     0,     0,     0,     0,     0,     0,     0,     0,    90,
      34,    35,    36,    37,    38,    39,    40,    41,    42,    43,
      44,    45,   127,    87,     0,     0,     0,     0,     0,     0,
     157,    34,    35,    36,    37,    38,    39,    40,    41,    42,
      43,    44,    45,    34,    35,    36,    37,    38,    39,    40,
      41,    42,    43,    44,    45,     0,     0,     0,     0,     0,
       0,     0,   132,    34,    35,    36,    37,    38,    39,    40,
      41,    42,    43,    44,    45,     0,     0,     0,     0,   120,
      34,    35,    36,    37,    38,    39,    40,    41,    42,    43,
      44,    45,    99,     0,     0,    51,    34,    35,    36,    37,
      38,    39,    40,    41,    42,    43,    44,    45,    34,    35,
      36,    37,    38,    39,    40,    41,    42,    43,    44,    45,
      34,    35,    36,    37,    -4,    -4,    -4,    -4,    -4,    -4,
      34,    35,    36,    37,    38,    39,    40,    41,    42,    43
};

static const yytype_int16 yycheck[] =
{
       0,     3,     7,     7,     7,     5,     3,     4,     5,     3,
       3,    13,     9,    10,    87,    11,    20,    20,   140,    15,
      14,    14,    95,    28,    24,     0,     9,    29,   150,    29,
      13,    31,    28,    30,     3,     3,    33,    34,    18,    19,
      37,    10,     3,    10,    41,    42,    46,    28,     3,    46,
      38,    51,    43,    45,     3,     4,     5,    43,    44,    45,
       9,    10,     3,    10,    20,     9,     6,    67,    68,    69,
      70,    71,    72,    73,    74,    75,    76,    77,    78,    79,
      14,    30,     3,    20,    33,    34,    40,     3,    37,     6,
      90,    91,    41,    42,    39,     7,    10,    46,    40,    16,
      17,    18,    19,    20,    21,    22,    23,    24,    25,    26,
      27,     3,     6,    40,   114,     3,   116,     3,     3,    28,
     120,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,   132,    14,     3,     3,    20,    20,   138,    59,
      63,   114,    61,   117,   144,     2,     3,     4,   148,     6,
       7,     8,     9,    10,    11,    -1,    -1,   157,    -1,    -1,
      17,    18,   162,    -1,   164,     3,     4,     5,   168,    -1,
      -1,     9,    -1,   173,    -1,    32,    33,    34,    35,    36,
      37,    38,    39,    40,    41,    42,    43,    44,    45,    -1,
      -1,    -1,    30,    -1,    -1,    33,    34,    -1,    55,    37,
      -1,    -1,    -1,    41,    42,    -1,    -1,    -1,    46,    16,
      17,    18,    19,    20,    21,    22,    23,    24,    25,    26,
      27,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    36,
      16,    17,    18,    19,    20,    21,    22,    23,    24,    25,
      26,    27,    99,     8,    -1,    -1,    -1,    -1,    -1,    -1,
      36,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    16,    17,    18,    19,    20,    21,    22,
      23,    24,    25,    26,    27,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    35,    16,    17,    18,    19,    20,    21,    22,
      23,    24,    25,    26,    27,    -1,    -1,    -1,    -1,    32,
      16,    17,    18,    19,    20,    21,    22,    23,    24,    25,
      26,    27,    12,    -1,    -1,    31,    16,    17,    18,    19,
      20,    21,    22,    23,    24,    25,    26,    27,    16,    17,
      18,    19,    20,    21,    22,    23,    24,    25,    26,    27,
      16,    17,    18,    19,    20,    21,    22,    23,    24,    25,
      16,    17,    18,    19,    20,    21,    22,    23,    24,    25
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,     4,     5,     9,    30,    33,    34,    37,    41,
      42,    46,    48,    60,    61,    62,    64,     9,    13,    49,
      49,    49,    49,    61,    49,    49,    49,    49,    49,    49,
       0,    11,    15,    28,    16,    17,    18,    19,    20,    21,
      22,    23,    24,    25,    26,    27,    49,    49,    10,    61,
      63,    31,    61,     3,    43,    44,    45,    50,    51,    52,
      53,    54,    55,    56,    61,    61,    49,    49,    49,    49,
      49,    49,    49,    49,    49,    49,    49,    49,    49,    49,
      10,    61,    65,     3,    14,    66,    67,     8,    10,    61,
      36,    28,     3,    49,     3,    38,    51,    53,    55,    12,
       3,    61,    61,    61,    61,    61,    61,    61,    61,    61,
      61,    61,    61,    61,     6,    10,    20,     6,    14,    63,
      32,    61,    61,     9,     3,    20,    63,    49,    65,    61,
      67,    61,    35,     3,    10,    58,    59,     7,    28,     3,
      13,    29,    57,    39,    40,    61,     7,     7,    20,    10,
       6,     3,    61,    14,    58,    40,    61,    36,     3,     3,
      61,     7,    20,    58,    28,    14,     3,    61,    20,     3,
      61,    61,    61,    20,    61
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    47,    48,    49,    50,    50,    51,    51,    52,    52,
      52,    52,    53,    53,    54,    54,    54,    54,    55,    55,
      56,    57,    57,    57,    57,    58,    58,    59,    60,    60,
      60,    61,    61,    61,    61,    61,    61,    61,    61,    61,
      61,    61,    61,    61,    61,    61,    61,    61,    61,    61,
      61,    61,    61,    61,    61,    61,    61,    61,    61,    61,
      62,    62,    63,    63,    64,    64,    65,    65,    66,    67,
      67
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     0,     0,     1,     1,     2,     1,     5,
       7,     1,     1,     2,     6,     7,     8,     9,     1,     2,
       4,     1,     2,     3,     3,     1,     3,     3,     2,     4,
       4,     1,     2,     2,     2,     3,     1,     4,     4,     4,
       4,     4,     4,     4,     4,     4,     4,     4,     4,     4,
       5,     1,     7,     4,     6,     4,     5,     9,     2,     6,
       3,     4,     1,     3,     4,     5,     1,     3,     3,     1,
       3
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 90 "tiger.y" /* yacc.c:1648  */
    { absyn_root = (yyvsp[0].exp); }
#line 1438 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 3:
#line 92 "tiger.y" /* yacc.c:1648  */
    { (yyval.pos) = EM_tokPos; }
#line 1444 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 4:
#line 94 "tiger.y" /* yacc.c:1648  */
    { 
                (yyval.dec_lst) = NULL; 
        }
#line 1452 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 5:
#line 97 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.dec_lst) = (yyvsp[0].dec_lst); 
        }
#line 1460 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 6:
#line 102 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.dec_lst) = A_DecList((yyvsp[0].dec), NULL);
        }
#line 1468 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 7:
#line 105 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.dec_lst) = A_DecList((yyvsp[-1].dec), (yyvsp[0].dec_lst));
        }
#line 1476 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 8:
#line 110 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.dec) = A_TypeDec(EM_tokPos, (yyvsp[0].namety_lst));
        }
#line 1484 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 9:
#line 113 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.dec) = A_VarDec((yyvsp[-3].pos), S_Symbol((yyvsp[-2].sval)), NULL, (yyvsp[0].exp));
        }
#line 1492 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 10:
#line 116 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.dec) = A_VarDec((yyvsp[-5].pos), S_Symbol((yyvsp[-4].sval)), S_Symbol((yyvsp[-2].sval)), (yyvsp[0].exp));
        }
#line 1500 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 11:
#line 119 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.dec) = A_FunctionDec(EM_tokPos, (yyvsp[0].fun_dec_lst));
        }
#line 1508 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 12:
#line 124 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.fun_dec_lst) = A_FundecList((yyvsp[0].fun_dec), NULL);
        }
#line 1516 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 13:
#line 127 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.fun_dec_lst) = A_FundecList((yyvsp[-1].fun_dec), (yyvsp[0].fun_dec_lst));
}
#line 1524 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 14:
#line 132 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.fun_dec) = A_Fundec(EM_tokPos, S_Symbol((yyvsp[-4].sval)), NULL, NULL, (yyvsp[0].exp));
        }
#line 1532 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 15:
#line 135 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.fun_dec) = A_Fundec(EM_tokPos, S_Symbol((yyvsp[-5].sval)), (yyvsp[-3].field_lst), NULL, (yyvsp[0].exp));
        }
#line 1540 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 16:
#line 138 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.fun_dec) = A_Fundec(EM_tokPos, S_Symbol((yyvsp[-6].sval)), NULL, S_Symbol((yyvsp[-2].sval)), (yyvsp[0].exp));
        }
#line 1548 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 17:
#line 141 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.fun_dec) = A_Fundec(EM_tokPos, S_Symbol((yyvsp[-7].sval)), (yyvsp[-5].field_lst), 
                                S_Symbol((yyvsp[-2].sval)), (yyvsp[0].exp));
        }
#line 1557 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 18:
#line 154 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.namety_lst) = A_NametyList((yyvsp[0].namety), NULL);
        }
#line 1565 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 19:
#line 157 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.namety_lst) = A_NametyList((yyvsp[-1].namety), (yyvsp[0].namety_lst));
        }
#line 1573 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 20:
#line 162 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.namety) = A_Namety(S_Symbol((yyvsp[-2].sval)), (yyvsp[0].ty));
        }
#line 1581 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 21:
#line 167 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.ty) = A_NameTy(EM_tokPos, S_Symbol((yyvsp[0].sval)));
        }
#line 1589 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 22:
#line 170 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.ty) = A_RecordTy(EM_tokPos, NULL);
        }
#line 1597 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 23:
#line 173 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.ty) = A_RecordTy(EM_tokPos, (yyvsp[-1].field_lst));
        }
#line 1605 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 24:
#line 176 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.ty) = A_ArrayTy(EM_tokPos, S_Symbol((yyvsp[0].sval)));
        }
#line 1613 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 25:
#line 181 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.field_lst) = A_FieldList((yyvsp[0].field), NULL);
        }
#line 1621 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 26:
#line 184 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.field_lst) = A_FieldList((yyvsp[-2].field), (yyvsp[0].field_lst));
        }
#line 1629 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 27:
#line 189 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.field) = A_Field(EM_tokPos, S_Symbol((yyvsp[-2].sval)), S_Symbol((yyvsp[0].sval)));
        }
#line 1637 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 28:
#line 194 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.var) = A_SimpleVar((yyvsp[0].pos), S_Symbol((yyvsp[-1].sval)));

        }
#line 1646 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 29:
#line 198 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.var) = A_FieldVar((yyvsp[-1].pos), (yyvsp[-3].var), S_Symbol((yyvsp[0].sval)));
        }
#line 1654 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 30:
#line 201 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.var) = A_SubscriptVar(EM_tokPos, (yyvsp[-3].var), (yyvsp[-1].exp));
        }
#line 1662 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 31:
#line 205 "tiger.y" /* yacc.c:1648  */
    { 
                (yyval.exp) = A_VarExp(EM_tokPos, (yyvsp[0].var));
        }
#line 1670 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 32:
#line 208 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_NilExp((yyvsp[0].pos));
        }
#line 1678 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 33:
#line 211 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_IntExp((yyvsp[0].pos), (yyvsp[-1].ival));
        }
#line 1686 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 34:
#line 214 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_StringExp((yyvsp[0].pos), (yyvsp[-1].sval));
        }
#line 1694 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 35:
#line 217 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_OpExp( (yyvsp[-1].pos), A_minusOp, A_IntExp((yyvsp[-1].pos),0), (yyvsp[0].exp));
        }
#line 1702 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 36:
#line 220 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = (yyvsp[0].exp); 
        }
#line 1710 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 37:
#line 223 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_OpExp( (yyvsp[-1].pos), A_plusOp, (yyvsp[-3].exp), (yyvsp[0].exp));
        }
#line 1718 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 38:
#line 226 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_OpExp( (yyvsp[-1].pos), A_minusOp,(yyvsp[-3].exp),(yyvsp[0].exp));
        }
#line 1726 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 39:
#line 229 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_OpExp((yyvsp[-1].pos), A_timesOp, (yyvsp[-3].exp), (yyvsp[0].exp));
        }
#line 1734 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 40:
#line 232 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_OpExp((yyvsp[-1].pos), A_divideOp, (yyvsp[-3].exp), (yyvsp[0].exp));
        }
#line 1742 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 41:
#line 235 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_OpExp((yyvsp[-1].pos), A_eqOp, (yyvsp[-3].exp), (yyvsp[0].exp));
        }
#line 1750 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 42:
#line 238 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_OpExp((yyvsp[-1].pos), A_neqOp, (yyvsp[-3].exp), (yyvsp[0].exp));
        }
#line 1758 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 43:
#line 241 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_OpExp((yyvsp[-1].pos), A_gtOp, (yyvsp[-3].exp), (yyvsp[0].exp));
        }
#line 1766 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 44:
#line 244 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_OpExp((yyvsp[-1].pos), A_ltOp, (yyvsp[-3].exp), (yyvsp[0].exp));
        }
#line 1774 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 45:
#line 247 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_OpExp((yyvsp[-1].pos), A_geOp, (yyvsp[-3].exp), (yyvsp[0].exp));
        }
#line 1782 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 46:
#line 250 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_OpExp((yyvsp[-1].pos), A_leOp, (yyvsp[-3].exp), (yyvsp[0].exp));
        }
#line 1790 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 47:
#line 253 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_OpExp((yyvsp[-1].pos), A_andOp, (yyvsp[-3].exp), (yyvsp[0].exp));
                        
        }
#line 1799 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 48:
#line 257 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_OpExp((yyvsp[-1].pos), A_orOp, (yyvsp[-3].exp), (yyvsp[0].exp));
        }
#line 1807 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 49:
#line 260 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_RecordExp( (yyvsp[-1].pos), S_Symbol((yyvsp[-3].sval)), NULL);
        }
#line 1815 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 50:
#line 263 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_RecordExp((yyvsp[-2].pos), S_Symbol((yyvsp[-4].sval)), (yyvsp[-1].efield_lst));
}
#line 1823 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 51:
#line 266 "tiger.y" /* yacc.c:1648  */
    { 
                (yyval.exp) = (yyvsp[0].exp);
        }
#line 1831 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 52:
#line 270 "tiger.y" /* yacc.c:1648  */
    {
                // Check that l_val is a lone identifier. 
                if ((yyvsp[-6].var)->kind !=A_simpleVar) {
                        yyerror("Expected id in array creation.");
                        exit(0);
                }
                
                (yyval.exp) = A_ArrayExp((yyvsp[-2].pos),(yyvsp[-6].var)->u.simple,(yyvsp[-4].exp),(yyvsp[0].exp));
        }
#line 1845 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 53:
#line 279 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_AssignExp((yyvsp[-1].pos), (yyvsp[-3].var), (yyvsp[0].exp));
        }
#line 1853 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 54:
#line 282 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_IfExp(EM_tokPos, (yyvsp[-4].exp), (yyvsp[-2].exp), (yyvsp[0].exp));
        }
#line 1861 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 55:
#line 285 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_IfExp(EM_tokPos, (yyvsp[-2].exp), (yyvsp[0].exp), NULL);
        }
#line 1869 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 56:
#line 288 "tiger.y" /* yacc.c:1648  */
    {
               (yyval.exp) = A_WhileExp((yyvsp[-3].pos), (yyvsp[-2].exp), (yyvsp[0].exp)); 
        }
#line 1877 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 57:
#line 291 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_ForExp((yyvsp[-7].pos), S_Symbol((yyvsp[-6].sval)), (yyvsp[-4].exp), (yyvsp[-2].exp), (yyvsp[0].exp));
        }
#line 1885 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 58:
#line 294 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_BreakExp((yyvsp[0].pos));
        }
#line 1893 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 59:
#line 297 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_LetExp((yyvsp[-4].pos), (yyvsp[-3].dec_lst), A_SeqExp(EM_tokPos, (yyvsp[-1].exp_lst))); 
        }
#line 1901 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 60:
#line 302 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_SeqExp((yyvsp[-1].pos), NULL);
        }
#line 1909 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 61:
#line 305 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_SeqExp((yyvsp[-2].pos), (yyvsp[-1].exp_lst));
        }
#line 1917 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 62:
#line 310 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp_lst) = A_ExpList((yyvsp[0].exp), NULL);
        }
#line 1925 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 63:
#line 313 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp_lst) = A_ExpList((yyvsp[-2].exp), (yyvsp[0].exp_lst));
        }
#line 1933 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 64:
#line 318 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_CallExp((yyvsp[-1].pos), S_Symbol((yyvsp[-3].sval)),NULL);
        }
#line 1941 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 65:
#line 321 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.exp) = A_CallExp((yyvsp[-2].pos), S_Symbol((yyvsp[-4].sval)), (yyvsp[-1].arg_lst));
        }
#line 1949 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 66:
#line 326 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.arg_lst) = A_ExpList((yyvsp[0].exp), NULL);
        }
#line 1957 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 67:
#line 329 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.arg_lst) = A_ExpList((yyvsp[-2].exp), (yyvsp[0].arg_lst));
        }
#line 1965 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 68:
#line 334 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.efield) = A_Efield(S_Symbol((yyvsp[-2].sval)), (yyvsp[0].exp));
        }
#line 1973 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 69:
#line 339 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.efield_lst) = A_EfieldList((yyvsp[0].efield), NULL);
        }
#line 1981 "tiger.tab.c" /* yacc.c:1648  */
    break;

  case 70:
#line 342 "tiger.y" /* yacc.c:1648  */
    {
                (yyval.efield_lst) = A_EfieldList((yyvsp[-2].efield),(yyvsp[0].efield_lst));
        }
#line 1989 "tiger.tab.c" /* yacc.c:1648  */
    break;


#line 1993 "tiger.tab.c" /* yacc.c:1648  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
