package An_Sintactic_Shift_Reduce is

    type Small_Integer is range -32_000 .. 32_000;

    type Shift_Reduce_Entry is record
        T   : Small_Integer;
        Act : Small_Integer;
    end record;
    pragma Pack(Shift_Reduce_Entry);

    subtype Row is Integer range -1 .. Integer'Last;

  --pragma suppress(index_check);

    type Shift_Reduce_Array is array (Row  range <>) of Shift_Reduce_Entry;

    Shift_Reduce_Matrix : constant Shift_Reduce_Array :=
        ( (-1,-1) -- Dummy Entry

-- state  0
,( 13, 2),(-1,-3000)
-- state  1
,(-1,-1)
-- state  2
,( 41, 4)
,(-1,-3000)
-- state  3
,( 0,-3001),(-1,-3000)
-- state  4
,( 29, 7)
,(-1,-4)
-- state  5
,( 24, 9),(-1,-3000)
-- state  6
,(-1,-3000)

-- state  7
,( 41, 12),(-1,-3000)
-- state  8
,(-1,-3)
-- state  9
,(-1,-13)

-- state  10
,( 28, 15),( 30, 14),(-1,-3000)
-- state  11
,(-1,-7)

-- state  12
,( 27, 16),(-1,-3000)
-- state  13
,( 2, 27),( 13, 2)
,( 18, 26),( 41, 25),(-1,-3000)
-- state  14
,(-1,-5)

-- state  15
,( 41, 12),(-1,-3000)
-- state  16
,( 12, 31),( 25, 30)
,(-1,-3000)
-- state  17
,(-1,-14)
-- state  18
,(-1,-15)
-- state  19
,(-1,-16)

-- state  20
,(-1,-17)
-- state  21
,( 27, 33),( 36, 34),(-1,-3000)

-- state  22
,(-1,-26)
-- state  23
,(-1,-27)
-- state  24
,(-1,-28)
-- state  25
,(-1,-20)

-- state  26
,( 41, 35),(-1,-3000)
-- state  27
,(-1,-36)
-- state  28
,(-1,-12)

-- state  29
,(-1,-6)
-- state  30
,( 12, 37),(-1,-9)
-- state  31
,(-1,-10)

-- state  32
,( 41, 38),(-1,-3000)
-- state  33
,( 9, 40),( 41, 39)
,(-1,-3000)
-- state  34
,( 41, 41),(-1,-3000)
-- state  35
,( 24, 42)
,(-1,-3000)
-- state  36
,( 3, 51),( 4, 48),( 7, 47)
,( 41, 50),(-1,-3000)
-- state  37
,(-1,-11)
-- state  38
,(-1,-8)

-- state  39
,( 28, 53),(-1,-3000)
-- state  40
,( 41, 54),(-1,-3000)

-- state  41
,(-1,-19)
-- state  42
,( 10, 55),( 15, 57),( 19, 56)
,(-1,-3000)
-- state  43
,(-1,-37)
-- state  44
,(-1,-38)
-- state  45
,(-1,-39)

-- state  46
,(-1,-40)
-- state  47
,( 22, 61),( 29, 60),( 31, 59)
,( 41, 50),( 42, 63),(-1,-3000)
-- state  48
,( 22, 61)
,( 29, 60),( 31, 59),( 41, 50),( 42, 63)
,(-1,-3000)
-- state  49
,( 28, 66),( 39, 65),(-1,-3000)

-- state  50
,(-1,-47)
-- state  51
,( 41, 68),(-1,-3000)
-- state  52
,(-1,-35)

-- state  53
,(-1,-18)
-- state  54
,( 39, 69),(-1,-3000)
-- state  55
,( 41, 70)
,(-1,-3000)
-- state  56
,( 29, 71),(-1,-3000)
-- state  57
,( 41, 74)
,(-1,-3000)
-- state  58
,( 8, 75),( 20, 81),( 21, 82)
,( 26, 80),( 31, 77),( 32, 76),( 33, 78)
,( 34, 79),( 35, 84),( 40, 83),(-1,-3000)

-- state  59
,( 22, 61),( 29, 60),( 31, 59),( 41, 50)
,( 42, 63),(-1,-3000)
-- state  60
,( 22, 61),( 29, 60)
,( 31, 59),( 41, 50),( 42, 63),(-1,-3000)

-- state  61
,( 22, 61),( 29, 60),( 31, 59),( 41, 50)
,( 42, 63),(-1,-3000)
-- state  62
,(-1,-65)
-- state  63
,(-1,-66)

-- state  64
,( 6, 88),( 20, 81),( 21, 82),( 26, 80)
,( 31, 77),( 32, 76),( 33, 78),( 34, 79)
,( 35, 84),( 40, 83),(-1,-3000)
-- state  65
,( 22, 61)
,( 29, 60),( 31, 59),( 41, 50),( 42, 63)
,(-1,-3000)
-- state  66
,(-1,-52)
-- state  67
,( 29, 91),( 37, 90)
,(-1,-45)
-- state  68
,( 28, 93),(-1,-3000)
-- state  69
,( 31, 95)
,( 41, 96),( 42, 94),(-1,-3000)
-- state  70
,( 16, 98)
,(-1,-3000)
-- state  71
,( 41, 25),(-1,-3000)
-- state  72
,( 3, 100)
,( 41, 74),(-1,-3000)
-- state  73
,(-1,-33)
-- state  74
,( 27, 102)
,(-1,-3000)
-- state  75
,(-1,-36)
-- state  76
,( 22, 61),( 29, 60)
,( 31, 59),( 41, 50),( 42, 63),(-1,-3000)

-- state  77
,( 22, 61),( 29, 60),( 31, 59),( 41, 50)
,( 42, 63),(-1,-3000)
-- state  78
,( 22, 61),( 29, 60)
,( 31, 59),( 41, 50),( 42, 63),(-1,-3000)

-- state  79
,( 22, 61),( 29, 60),( 31, 59),( 41, 50)
,( 42, 63),(-1,-3000)
-- state  80
,( 22, 61),( 29, 60)
,( 31, 59),( 41, 50),( 42, 63),(-1,-3000)

-- state  81
,( 22, 61),( 29, 60),( 31, 59),( 41, 50)
,( 42, 63),(-1,-3000)
-- state  82
,( 22, 61),( 29, 60)
,( 31, 59),( 41, 50),( 42, 63),(-1,-3000)

-- state  83
,( 22, 61),( 29, 60),( 31, 59),( 41, 50)
,( 42, 63),(-1,-3000)
-- state  84
,( 22, 61),( 29, 60)
,( 31, 59),( 41, 50),( 42, 63),(-1,-3000)

-- state  85
,( 26, 80),( 33, 78),( 34, 79),(-1,-62)

-- state  86
,( 20, 81),( 21, 82),( 26, 80),( 30, 113)
,( 31, 77),( 32, 76),( 33, 78),( 34, 79)
,( 35, 84),( 40, 83),(-1,-3000)
-- state  87
,( 26, 80)
,( 31, 77),( 32, 76),( 33, 78),( 34, 79)
,( 35, 84),( 40, 83),(-1,-64)
-- state  88
,(-1,-36)

-- state  89
,( 20, 81),( 21, 82),( 26, 80),( 28, 115)
,( 31, 77),( 32, 76),( 33, 78),( 34, 79)
,( 35, 84),( 40, 83),(-1,-3000)
-- state  90
,( 41, 116)
,(-1,-3000)
-- state  91
,( 22, 61),( 29, 60),( 31, 59)
,( 41, 50),( 42, 63),(-1,-3000)
-- state  92
,(-1,-46)

-- state  93
,(-1,-2)
-- state  94
,(-1,-22)
-- state  95
,( 41, 120),( 42, 119)
,(-1,-3000)
-- state  96
,(-1,-24)
-- state  97
,( 28, 121),(-1,-3000)

-- state  98
,( 31, 95),( 41, 96),( 42, 94),(-1,-3000)

-- state  99
,( 30, 123),( 36, 34),(-1,-3000)
-- state  100
,( 15, 124)
,(-1,-3000)
-- state  101
,(-1,-32)
-- state  102
,( 41, 125),(-1,-3000)

-- state  103
,( 3, 126),( 4, 48),( 7, 47),( 41, 50)
,(-1,-3000)
-- state  104
,( 26, 80),( 33, 78),( 34, 79)
,(-1,-53)
-- state  105
,( 26, 80),( 33, 78),( 34, 79)
,(-1,-54)
-- state  106
,(-1,-55)
-- state  107
,(-1,-56)
-- state  108
,(-1,-57)

-- state  109
,( 26, 80),( 31, 77),( 32, 76),( 33, 78)
,( 34, 79),( 35, 84),( 40, 83),(-1,-58)

-- state  110
,( 26, 80),( 31, 77),( 32, 76),( 33, 78)
,( 34, 79),( 35, 84),( 40, 83),(-1,-59)

-- state  111
,( 26, 80),( 31, 77),( 32, 76),( 33, 78)
,( 34, 79),( 35,-3000),( 40,-3000),(-1,-60)

-- state  112
,( 26, 80),( 31, 77),( 32, 76),( 33, 78)
,( 34, 79),( 35,-3000),( 40,-3000),(-1,-61)

-- state  113
,(-1,-63)
-- state  114
,( 3, 127),( 4, 48),( 5, 128)
,( 7, 47),( 41, 50),(-1,-3000)
-- state  115
,(-1,-44)

-- state  116
,(-1,-48)
-- state  117
,( 30, 129),( 36, 130),(-1,-3000)

-- state  118
,( 20, 81),( 21, 82),( 26, 80),( 31, 77)
,( 32, 76),( 33, 78),( 34, 79),( 35, 84)
,( 40, 83),(-1,-51)
-- state  119
,(-1,-23)
-- state  120
,(-1,-25)

-- state  121
,(-1,-21)
-- state  122
,( 38, 131),(-1,-3000)
-- state  123
,( 23, 132)
,(-1,-3000)
-- state  124
,( 28, 133),(-1,-3000)
-- state  125
,( 28, 134)
,(-1,-3000)
-- state  126
,( 8, 135),(-1,-3000)
-- state  127
,( 4, 136)
,(-1,-3000)
-- state  128
,(-1,-36)
-- state  129
,(-1,-49)
-- state  130
,( 22, 61)
,( 29, 60),( 31, 59),( 41, 50),( 42, 63)
,(-1,-3000)
-- state  131
,( 31, 95),( 41, 96),( 42, 94)
,(-1,-3000)
-- state  132
,( 41, 140),(-1,-3000)
-- state  133
,(-1,-31)

-- state  134
,(-1,-34)
-- state  135
,( 28, 141),(-1,-3000)
-- state  136
,( 28, 142)
,(-1,-3000)
-- state  137
,( 3, 143),( 4, 48),( 7, 47)
,( 41, 50),(-1,-3000)
-- state  138
,( 20, 81),( 21, 82)
,( 26, 80),( 31, 77),( 32, 76),( 33, 78)
,( 34, 79),( 35, 84),( 40, 83),(-1,-50)

-- state  139
,( 28, 144),(-1,-3000)
-- state  140
,( 28, 145),(-1,-3000)

-- state  141
,(-1,-41)
-- state  142
,(-1,-42)
-- state  143
,( 4, 146),(-1,-3000)

-- state  144
,(-1,-29)
-- state  145
,(-1,-30)
-- state  146
,( 28, 147),(-1,-3000)

-- state  147
,(-1,-43)
);
--  The offset vector
SHIFT_REDUCE_OFFSET : array (0.. 147) of Integer :=
( 0,
 2, 3, 5, 7, 9, 11, 12, 14, 15, 16,
 19, 20, 22, 27, 28, 30, 33, 34, 35, 36,
 37, 40, 41, 42, 43, 44, 46, 47, 48, 49,
 51, 52, 54, 57, 59, 61, 66, 67, 68, 70,
 72, 73, 77, 78, 79, 80, 81, 87, 93, 96,
 97, 99, 100, 101, 103, 105, 107, 109, 120, 126,
 132, 138, 139, 140, 151, 157, 158, 161, 163, 167,
 169, 171, 174, 175, 177, 178, 184, 190, 196, 202,
 208, 214, 220, 226, 232, 236, 247, 255, 256, 267,
 269, 275, 276, 277, 278, 281, 282, 284, 288, 291,
 293, 294, 296, 301, 305, 309, 310, 311, 312, 320,
 328, 336, 344, 345, 351, 352, 353, 356, 366, 367,
 368, 369, 371, 373, 375, 377, 379, 381, 382, 383,
 389, 393, 395, 396, 397, 399, 401, 406, 416, 418,
 420, 421, 422, 424, 425, 426, 428);
end An_Sintactic_Shift_Reduce;
