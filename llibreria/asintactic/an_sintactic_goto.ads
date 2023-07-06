package An_Sintactic_Goto is

    type Small_Integer is range -32_000 .. 32_000;

    type Goto_Entry is record
        Nonterm  : Small_Integer;
        Newstate : Small_Integer;
    end record;

  --pragma suppress(index_check);

    subtype Row is Integer range -1 .. Integer'Last;

    type Goto_Parse_Table is array (Row range <>) of Goto_Entry;

    Goto_Matrix : constant Goto_Parse_Table :=
       ((-1,-1)  -- Dummy Entry.
-- State  0
,(-3, 1),(-2, 3)
-- State  1

-- State  2
,(-4, 5)
-- State  3

-- State  4
,(-7, 8)

-- State  5

-- State  6

-- State  7
,(-9, 11),(-8, 10)
-- State  8

-- State  9
,(-5, 13)
-- State  10

-- State  11

-- State  12

-- State  13
,(-19, 24)
,(-18, 23),(-17, 22),(-15, 21),(-14, 19)
,(-13, 18),(-12, 17),(-11, 28),(-3, 20)

-- State  14

-- State  15
,(-9, 29)
-- State  16
,(-10, 32)
-- State  17

-- State  18

-- State  19

-- State  20

-- State  21

-- State  22

-- State  23

-- State  24

-- State  25

-- State  26

-- State  27
,(-6, 36)
-- State  28

-- State  29

-- State  30

-- State  31

-- State  32

-- State  33

-- State  34

-- State  35

-- State  36
,(-28, 49)
,(-26, 46),(-25, 45),(-24, 44),(-23, 43)
,(-22, 52)
-- State  37

-- State  38

-- State  39

-- State  40

-- State  41

-- State  42

-- State  43

-- State  44

-- State  45

-- State  46

-- State  47
,(-28, 62),(-27, 58)
-- State  48
,(-28, 62)
,(-27, 64)
-- State  49

-- State  50
,(-29, 67)
-- State  51

-- State  52

-- State  53

-- State  54

-- State  55

-- State  56

-- State  57
,(-21, 73),(-20, 72)

-- State  58

-- State  59
,(-28, 62),(-27, 85)
-- State  60
,(-28, 62),(-27, 86)

-- State  61
,(-28, 62),(-27, 87)
-- State  62

-- State  63

-- State  64

-- State  65
,(-28, 62),(-27, 89)

-- State  66

-- State  67
,(-30, 92)
-- State  68

-- State  69
,(-16, 97)
-- State  70

-- State  71
,(-15, 99)
-- State  72
,(-21, 101)

-- State  73

-- State  74

-- State  75
,(-6, 103)
-- State  76
,(-28, 62),(-27, 104)
-- State  77
,(-28, 62)
,(-27, 105)
-- State  78
,(-28, 62),(-27, 106)
-- State  79
,(-28, 62)
,(-27, 107)
-- State  80
,(-28, 62),(-27, 108)
-- State  81
,(-28, 62)
,(-27, 109)
-- State  82
,(-28, 62),(-27, 110)
-- State  83
,(-28, 62)
,(-27, 111)
-- State  84
,(-28, 62),(-27, 112)
-- State  85

-- State  86

-- State  87

-- State  88
,(-6, 114)

-- State  89

-- State  90

-- State  91
,(-31, 117),(-28, 62),(-27, 118)
-- State  92

-- State  93

-- State  94

-- State  95

-- State  96

-- State  97

-- State  98
,(-16, 122)

-- State  99

-- State  100

-- State  101

-- State  102

-- State  103
,(-28, 49),(-26, 46),(-25, 45),(-24, 44)
,(-23, 43),(-22, 52)
-- State  104

-- State  105

-- State  106

-- State  107

-- State  108

-- State  109

-- State  110

-- State  111

-- State  112

-- State  113

-- State  114
,(-28, 49),(-26, 46)
,(-25, 45),(-24, 44),(-23, 43),(-22, 52)

-- State  115

-- State  116

-- State  117

-- State  118

-- State  119

-- State  120

-- State  121

-- State  122

-- State  123

-- State  124

-- State  125

-- State  126

-- State  127

-- State  128
,(-6, 137)
-- State  129

-- State  130
,(-28, 62),(-27, 138)
-- State  131
,(-16, 139)

-- State  132

-- State  133

-- State  134

-- State  135

-- State  136

-- State  137
,(-28, 49),(-26, 46),(-25, 45),(-24, 44)
,(-23, 43),(-22, 52)
-- State  138

-- State  139

-- State  140

-- State  141

-- State  142

-- State  143

-- State  144

-- State  145

-- State  146

-- State  147

);
--  The offset vector
GOTO_OFFSET : array (0.. 147) of Integer :=
( 0,
 2, 2, 3, 3, 4, 4, 4, 6, 6, 7,
 7, 7, 7, 16, 16, 17, 18, 18, 18, 18,
 18, 18, 18, 18, 18, 18, 18, 19, 19, 19,
 19, 19, 19, 19, 19, 19, 25, 25, 25, 25,
 25, 25, 25, 25, 25, 25, 25, 27, 29, 29,
 30, 30, 30, 30, 30, 30, 30, 32, 32, 34,
 36, 38, 38, 38, 38, 40, 40, 41, 41, 42,
 42, 43, 44, 44, 44, 45, 47, 49, 51, 53,
 55, 57, 59, 61, 63, 63, 63, 63, 64, 64,
 64, 67, 67, 67, 67, 67, 67, 67, 68, 68,
 68, 68, 68, 74, 74, 74, 74, 74, 74, 74,
 74, 74, 74, 74, 80, 80, 80, 80, 80, 80,
 80, 80, 80, 80, 80, 80, 80, 80, 81, 81,
 83, 84, 84, 84, 84, 84, 84, 90, 90, 90,
 90, 90, 90, 90, 90, 90, 90);

subtype Rule        is Natural;
subtype Nonterminal is Integer;

   Rule_Length : array (Rule range  0 ..  66) of Natural := ( 2,
 1, 9, 2, 1, 3, 3, 1, 4,
 1, 1, 2, 2, 0, 1, 1, 1,
 1, 4, 3, 1, 7, 1, 2, 1,
 2, 1, 1, 1, 10, 10, 8, 2,
 1, 4, 2, 0, 1, 1, 1, 1,
 7, 7, 9, 4, 2, 2, 0, 2,
 3, 3, 1, 2, 3, 3, 3, 3,
 3, 3, 3, 3, 3, 2, 3, 2,
 1, 1);
   Get_LHS_Rule: array (Rule range  0 ..  66) of Nonterminal := (-1,
-2,-3,-4,-4,-7,-8,-8,-9,
-10,-10,-10,-5,-5,-11,-11,-11,
-11,-12,-15,-15,-13,-16,-16,-16,
-16,-14,-14,-14,-17,-18,-19,-20,
-20,-21,-6,-6,-22,-22,-22,-22,
-23,-24,-24,-25,-28,-29,-29,-30,
-30,-31,-31,-26,-27,-27,-27,-27,
-27,-27,-27,-27,-27,-27,-27,-27,
-27,-27);
end An_Sintactic_Goto;
