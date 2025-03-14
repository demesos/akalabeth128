!--------------------------------------------------
!- Akalabeth 128, A Commodore 128 port of
!- Akalabeth: World of Doom (1979) by Richard Garriott, 
!- ported to the Commodore 128 (VIC II/40 column mode)
!- in Commodore 128 BASIC 7/7.1 by Fox Cunning
!- Version 1.2 contains fixes from Wil Elmenreich in lines
!- 384-386 Line was longer than 255 bytes causing the relink to hang after loading
!- 6030 missing PRINT inserted
!- 1700-1720 don't clear screen after showing stats but wait for return key
!--------------------------------------------------
0 TRAP 4
1 REM:AKALABETH:WORLD-OF-DOOM-(C)1979-BY-RICHARD-GARRIOTT-C128-PORT-BY-FOX-CUNNING-(2022)
2 REM:VERSION1.2
4 CLR: BANK 15: GRAPHIC 0,1: SLOW: WINDOW 0,0,39,24
5 COLOR 0,1: COLOR 4,1: COLOR 5,2: CM=DEC("fff0"):REM:CURSOR MOVE
7 PRINTCHR$(142): SCNCLR: GOSUB 60000
8 ZZ = RND(-ABS(LN))
9 LEVEL = 0
10 GRAPHIC0,1: SYSCM,,11,0: PRINT" welcome to akalabeth, world of doom!"
20 DIM DN%(10,10),TE%(20,20),XX%(10),YY%(10),PER%(10,3),LD%(10,5),CD%(10,3),FT%(10,5),LAD%(10,3)
30 FOR X = 0 TO 20:TE%(X,0) = 1:TE%(0,X) = 1:TE%(X,20) = 1:TE%(20,X) = 1: NEXT
35 SYSCM,,22,0: PRINT"{space*2}(please wait)";
40 FOR X = 1 TO 19: FOR Y = 1 TO 19:TE%(X,Y) = INT(RND(1)^5 * 4.5)
41 IF TE%(X,Y) = 3 AND  RND (1) > .5 THEN TE%(X,Y) = 0
42 NEXT : PRINT ".";: NEXT
50 TE%(INT(RND(1)*19 + 1), INT(RND(1)*19 + 1)) = 5:TX =  INT(RND(1)*19 + 1):TY = INT(RND(1)*19 + 1):TE%(TX,TY) = 3
51 XX%(0) = 139:YY%(0) = 79
52 FOR X = 2 TO 20 STEP 2:XX%(X / 2) = INT(ATN(1/X) /  ATN(1)* 140 + .5):YY%(X / 2) = INT(XX%(X/2) * 4/7)
53 PER%(X/2,0) = 139 - XX%(X/2):PER%(X/2,1) = 139 + XX%(X/2):PER%(X/2,2) = 79 - YY%(X/2):PER%(X/2,3) = 79 + YY%(X/2): NEXT
54 PER%(0,0) = 0:PER%(0,1) = 279:PER%(0,2) = 0:PE%(0,3) = 159
55 FOR X = 1 TO 10:CD%(X,0) = 139 - XX%(X) / 3:CD%(X,1) = 139 + XX%(X) / 3:CD%(X,2) = 79 - YY%(X) * .7:CD%(X,3) = 79 + YY%(X): NEXT : PRINT ".";
56 FOR X = 0 TO 9:LD%(X,0) = (PER%(X,0) * 2 + PER%(X + 1,0)) / 3:LD%(X,1) = (PER%(X,0) + 2 * PER%(X + 1,0)) / 3:W = LD%(X,0) - PE%(X,0)
57 LD%(X,2) = PE%(X,2) + W * 4 / 7:LD%(X,3) = PER%(X,2) + 2 * W * 4 / 7:LD%(X,4) = (PE%(X,3) * 2 + PE%(X + 1,3)) / 3:LD%(X,5) = (PE%(X,3) + 2 * PE%(X + 1,3)) / 3
58 LD%(X,2) = LD%(X,4) - (LD%(X,4) - LD%(X,2)) * .8:LD%(X,3) = LD%(X,5) - (LD%(X,5) - LD%(X,3)) * .8: IF LD%(X,3) = LD%(X,4) THEN LD%(X,3) = LD%(X,3) - 1
59 NEXT
60 FOR X = 0 TO 9:FT%(X,0) = 139 - XX%(X) / 3:FT%(X,1) = 139 + XX%(X) / 3:FT%(X,2) = 139 - XX%(X + 1) / 3:FT%(X,3) = 139 + XX%(X + 1) / 3
61 FT%(X,4) = 79 + (YY%(X) * 2 + YY%(X + 1)) / 3:FT%(X,5) = 79 + (YY%(X)+ 2 * YY%(X + 1)) / 3: NEXT
62 FOR X = 0 TO 9:LAD%(X,0) = (FT%(X,0) * 2 + FT%(X,1)) / 3:LAD%(X,1) = (FT%(X,0) + 2 * FT%(X,1)) / 3:LAD%(X,3) = FT%(X,4):LAD%(X,2) = 159 - LAD%(X,3): NEXT
68 SCNCLR: COLOR 1,2
69 WINDOW 0,19,28,24
80 GOSUB 100: GOTO 1000
90 FOR X = 0 TO 9: FOR Y = 0 TO 5: PRINT LD%(X,Y);" ";: NEXT : PRINT : NEXT : GET Q$
100 GRAPHIC 2,1,20: FOR Y =  - 1 TO 1: FOR X =  - 1 TO 1
105 DRAW,138,75 TO 142,75: DRAW,140,73 TO 140,77
110 ZZ = TER%(TX + X,TY + Y):X1 = 65 + (X + 1) * 50:Y1 = (Y + 1) * 50
120 IF ZZ = 2 THEN DRAW,X1 + 20,Y1 + 20 TO X1 + 30,Y1 + 20 TO X1 + 30,Y1 + 30 TO X1 + 20,Y1 + 30 TO X1 + 20,Y1 + 20
130 IF ZZ = 3 THEN DRAW,X1 + 10,Y1 + 10 TO X1 + 20,Y1 + 10 TO X1 + 20,Y1 + 40 TO X1 + 10,Y1 + 40 TO X1 + 10,Y1 + 30 TO X1 + 40,Y1 + 30 TO X1 + 40,Y1 + 40 TO X1 + 30,Y1 + 40 TO X1 + 30,Y1 + 10 TO X1 + 40,Y1 + 10 TO X1 + 40,Y1 + 20 TO X1 + 10,Y1 + 20 TO X1 + 10,Y1 + 10
140 IF ZZ = 4 THEN DRAW,X1 + 20,Y1 + 20 TO X1 + 30,Y1 + 30: DRAW,X1 + 20,Y1 + 30 TO X1 + 30,Y1 + 20
150 IF ZZ = 5 THEN DRAW,X1,Y1 TO X1 + 50,Y1 TO X1 + 50,Y1 + 50 TO X1,Y1 + 50 TO X1,Y1: DRAW,X1 + 10,Y1 + 10 TO X1 + 10,Y1 + 40 TO X1 + 40,Y1 + 40 TO X1 + 40,Y1 + 10 TO X1 + 10,Y1 + 10 TO X1 + 40,Y1 + 40: DRAW,X1 + 10,Y1 + 40 TO X1 + 40,Y1 + 10
160 IF ZZ = 1 THEN DRAW,X1 + 10,Y1 + 50 TO X1 + 10,Y1 + 40 TO X1 + 20,Y1 + 30 TO X1 + 40,Y1 + 30 TO X1 + 40,Y1 + 50: DRAW,X1,Y1 + 10 TO X1 + 10,Y1 + 10: DRAW,X1 + 50,Y1 + 10 TO X1 + 40,Y1 + 10: DRAW,X1,Y1 + 40 TO X1 + 10,Y1 + 40: DRAW,X1 + 40,Y1 + 40 TO X1 + 50,Y1 + 40
170 IF ZZ = 1 THEN DRAW, X1 + 10,Y1 TO X1 + 10,Y1 + 20 TO X1 + 20,Y1 + 20 TO X1 + 20,Y1 + 30 TO X1 + 30,Y1 + 30 TO X1 + 30,Y1 + 10 TO X1 + 40,Y1 + 10 TO X1 + 40,Y1
190 NEXT: NEXT: RETURN
200 GRAPHIC 2,1,20: DIS=0: COLOR1,2
202 CENT = DNG%(PX + DX * DIS,PY + DY * DIS):LEFT = DNG%(PX + DX * DIS + DY,PY + DY * DIS - DX):RIGH = DNG%(PX + DX * DIS - DY,PY + DY * DIS + DX)
204 L1 = PER%(DIS,0):R1 = PER%(DIS,1):T1 = PER%(DIS,2):B1 = PER%(DIS,3):L2 = PER%(DIS + 1,0):R2 = PER%(DIS + 1,1):T2 = PER%(DIS + 1,2):B2 = PER%(DIS + 1,3)
205 CENT = INT(CENT):LEFT = INT(LEFT):RIGHT = INT(RIGHT)
206 MC = INT(CENT / 10):CENT = CENT - MC * 10:LEFT = INT((LEFT / 10 - INT(LEF / 10)) * 10 + .1):RIGH = INT((RIGH / 10 - INT(RIG / 10)) * 10 + .1)
208 IF DIS = 0 THEN 216
210 IF CENT = 1 OR CENT = 3 OR CENT = 4 THEN DRAW,L1,T1 TO R1,T1 TO R1,B1 TO L1,B1 TO L1,T1
212 IF CENT = 1 OR CENT = 3 THEN EN = 1: GOTO 260
214 IF CENT = 4 THEN DRAW,CD%(DIS,0),CD%(DIS,3) TO CD%(DIS,0),CD%(DIS,2) TO CD%(DIS,1),CD%(DIS,2) TO CD%(DIS,1),CD%(DIS,3):EN = 1: GOTO 260
216 IF LEFT = 1 OR LEFT = 3 OR LEFT = 4 THEN DRAW,L1,T1 TO L2,T2: DRAW,L1,B1 TO L2,B2
218 IF RIGH = 1 OR RIGH = 3 OR RIGH = 4 THEN DRAW,R1,T1 TO R2,T2: DRAW,R1,B1 TO R2,B2
220 IF LEFT = 4 AND DIS > 0 THEN DRAW,LD%(DIS,0),LD%(DIS,4) TO LD%(DIS,0),LD%(DIS,2) TO LD%(DIS,1),LD%(DIS,3) TO LD%(DIS,1),LD%(DIS,5)
222 IF LEFT = 4 AND DIS = 0 THEN DRAW,0,LD%(DIS,2) - 3 TO LD%(DIS,1),LD%(DIS,3) TO LD%(DIS,1),LD%(DIS,5)
224 IF RIGH = 4 AND DIS > 0 THEN DRAW,279 - LD%(DIS,0),LD%(DIS,4) TO 279 - LD%(DIS,0),LD%(DIS,2) TO 279 - LD%(DIS,1),LD%(DIS,3) TO 279 - LD%(DIS,1),LD%(DIS,5)
226 IF RIGH = 4 AND DIS = 0 THEN DRAW,279 - LD%(DIS,0),LD%(DIS,4) TO 279 - LD%(DIS,0),LD%(DIS,2) TO 279 - LD%(DIS,1),LD%(DIS,3) TO 279 - LD%(DIS,1),LD%(DIS,5)
228 IF LEFT = 3 OR LEFT = 1 OR LEFT = 4 THEN 234
230 IF DIS<>0 THEN DRAW,L1,T1 TO L1,B1
232 DRAW,L1,T2 TO L2,T2 TO L2,B2 TO L1,B2
234 IF RIGH = 3 OR RIGH = 1 OR RIGH = 4 THEN 240
236 IF DIS<>0 THEN DRAW,R1,T1 TO R1,B1
238 DRAW,R1,T2 TO R2,T2 TO R2,B2 TO R1,B2
240 IF CENT = 7 OR CENT = 9 THEN DRAW,FT%(DIS,0),FT%(DIS,4) TO FT%(DIS,2),FT%(DIS,5) TO FT%(DIS,3),FT%(DIS,5) TO FT%(DIS,1),FT%(DIS,4) TO FT%(DIS,0),FT%(DIS,4)
242 IF CENT = 8 THEN DRAW,FT%(DIS,0),158 - FT%(DIS,4) TO FT%(DIS,2),158 - FT%(DIS,5) TO FT%(DIS,3),158 - FT%(DIS,5) TO FT%(DIS,1),158 - FT%(DIS,4) TO FT%(DIS,0),158 - FT%(DIS,4)
244 IF CENT = 7 OR CENT = 8 THEN BASE = LAD%(DIS,3):TP = LAD%(DIS,2):LX= LAD%(DIS,0):RX = LAD%(DIS,1): DRAW,LX,BA TO LX,TP: DRAW,RX,TP TO RX,BA
246 IF CENT = 7 OR CENT = 8 THEN Y1 = (BA * 4 + TP) / 5:Y2 = (BA * 3 + TP * 2) / 5:Y3 = (BA * 2 + TP * 3) / 5:Y4 = (BA + TP * 4) / 5: DRAW,LX,Y1 TO RX,Y1: DRAW,LX,Y2 TO RX,Y2: DRAW,LX,Y3 TO RX,Y3: DRAW,LX,Y4 TO RX,Y4
248 IF DIS > 0 AND CENT = 5 THEN DRAW,139 - 10 / DIS,PER%(DIS,3) TO 139 - 10 / DIS,PER%(DIS,3) - 10 / DIS TO 139 + 10 / DIS,PER%(DIS,3) - 10 / DIS TO 139 + 10 / DIS,PER%(DIS,3) TO 139 - 10 / DIS,PER%(DIS,3)
249 IF CENT = 5 AND DIS > 0 THEN PRINT "{reverse on}chest!{reverse off}"
250 IF DIS > 0 AND CENT = 5 THEN DRAW,139 - 10 / DIS,PER%(DIS,3) - 10/ DIS TO 139 - 5 / DIS,PER%(DIS,3) - 15 / DIS TO 139 + 15 / DIS,PER%(DIS,3) - 15 / DIS TO 139 + 15 / DIS,PER%(DIS,3) - 5 / DIS TO 139 + 10 / DIS,PER%(DIS,3)
252 IF DIS > 0 AND CENT = 5 THEN DRAW,139 + 10 / DIS,PER%(DIS,3) - 10/ DIS TO 139 + 15 / DIS,PER%(DIS,3) - 15 / DIS
260 IF MC < 1 THEN 490
265 B = 79 + YY%(DIS):C = 139
266 PRINT"{reverse on}" : IF MC = 8 THEN  PRINT "chest!";: POKE240,27: SYS49164,81: PRINT : PRINT"{reverse off}": GOTO 269
267 PRINT M$(MC);: POKE240,27: SYS49164,81: PRINT : PRINT"{reverse off}"
269 IF DIS = 0 THEN 490
270 ON MC GOTO 300,310,320,330,340,350,360,370,380,390
280 GOTO 490
300 DRAW,C - 23 / DIS,B TO C - 15 / DIS,B TO C - 15 / DI,B - 15 / DI TO C - 8 / DI,B - 30 / DI TO C + 8 / DI,B - 30 / DI TO C + 15 / DI,B - 15 / DI TO C + 15 / DI,B TO C + 23 / DI,B
301 DRAW,C,B - 26 / DI TO C,B - 65 / DI: DRAW,C - 2 / DI + .5,B - 38 / DI TO C + 2 / DI + .5,B - 38 / DI: DRAW,C - 3 / DI + .5,B - 45 / DITO C + 3 / DI + .5,B - 45 / DI: DRAW,C - 5 / DI + .5,B - 53 / DI TO C + 5 / DI + .5,B - 53 / DI
302 DRAW,C - 23 / DI,B - 56 / DI TO C - 30 / DI,B - 53 / DI TO C - 23 / DI,B - 45 / DI TO C - 23 / DI,B - 53 / DI TO C - 8 / DI,B - 38 / DI
303 DRAW,C - 15 / DI,B - 45 / DI TO C - 8 / DI,B - 60 / DI TO C + 8 / DI,B - 60 / DI TO C + 15 / DI,B - 45 / DI: DRAW,C + 15 / DI,B - 42 / DI TO C + 15 / DI,B - 57 / DI: DRAW,C + 12 / DI,B - 45 / DI TO C + 20 / DI,B - 45 / DI
304 DRAW,C,B - 75 / DI TO C - 5 / DI + .5,B - 80 / DI TO C - 8 / DI,B - 75 / DI TO C - 5 / DI + .5,B - 65 / DI TO C + 5 / DI + .5,B - 65 / DI TO C + 5 / DI + .5,B - 68 / DI TO C - 5 / DI + .5,B - 68 / DI TO C- 5 / DI + .5,B - 65 / DI
305 DRAW TO C + 5 / DI + .5,B - 65 / DI TO C + 8 / DI,B - 75 / DI TO C + 5 / DI + .5,B - 80 / DI TO C - 5 / DI + .5,B - 80 / DI: DRAW,C - 5 / DI + .5,B - 72 / DI: DRAW,C + 5 / DI + .5,B - 72 / DI
309 GOTO 490
310 DRAW,C,B - 56 / DI TO C,B - 8 / DI TO C + 10 / DI,B TO C + 30 / DI,B TO C + 30 / DI,B - 45 / DI TO C + 10 / DI,B - 64 / DI TO C,B - 56/ DI
311 DRAW TO C - 10 / DI,B - 64 / DI TO C - 30 / DI,B - 45 / DI TO C - 30 / DI,B TO C - 10 / DI,B TO C,B - 8 / DI
312 DRAW,C - 10 / DI,B - 64 / DI TO C - 10 / DI,B - 75 / DI TO C,B - 83 / DI TO C + 10 / DI,B - 75 / DI TO C,B - 79 / DI TO C - 10 / DI,B - 75 / DI TO C,B - 60 / DI TO C + 10 / DI,B - 75 / DI TO C + 10 / DI,B- 64 / DI
319 GOTO 490
320 DRAW,C + 5 / DI,B - 30 / DI TO C,B - 25 / DI TO C - 5 / DI,B - 30 / DI TO C - 15 / DI,B - 5 / DI TO C - 10 / DI,B TO C + 10 / DI,B TO C + 15 / DI,B - 5 / DI
321 DRAW TO C + 20 / DI,B - 5 / DI TO C + 10 / DI,B TO C + 15 / DI,B - 5 / DI TO C + 5 / DI,B - 30 / DI TO C + 10 / DI,B - 40 / DI TO C + 3/ DI + .5,B - 35 / DI TO C - 3 / DI + .5,B - 35 / DI TO C - 10 / DI,B - 40 / DI TO C - 5 / DI,B - 30 / DI
322 DRAW,C - 5 / DI,B - 33 / DI TO C - 3 / DI + .5,B - 30 / DI: DRAW,C + 5 / DI,B - 33 / DI TO C + 3 / DI + .5,B - 30 / DI: DRAW,C - 5 / DI,B - 20 / DI TO C - 5 / DI,B - 15 / DI
323 DRAW,C + 5 / DI,B - 20 / DI TO C + 5 / DI,B - 15 / DI: DRAW,C - 7/ DI,B - 20 / DI TO C - 7 / DI,B - 15 / DI: DRAW,C + 7 / DI,B - 20/ DI TO C + 7 / DI,B - 15 / DI
329 GOTO 490
330 DRAW,C,B TO C - 15 / DI,B TO C - 8 / DI,B - 8 / DI TO C - 8 / DI,B- 15 / DI TO C - 15 / DI,B - 23 / DI TO C - 15 / DI,B - 15 / DI TO C - 23 / DI,B - 23 / DI
331 DRAW TO C - 23 / DI,B - 45 / DI TO C - 15 / DI,B - 53 / DI TO C - 8 / DI,B - 53 / DI TO C - 15 / DI,B - 68 / DI TO C - 8 / DI,B - 75 / DI TO C,B - 75 / DI
332 DRAW,C,B TO C + 15 / DI,B TO C + 8 / DI,B - 8 / DI TO C + 8 / DI,B- 15 / DI TO C + 15 / DI,B - 23 / DI TO C + 15 / DI,B - 15 / DI TO C + 23 / DI,B - 23 / DI
333 DRAW TO C + 23 / DI,B - 45 / DI TO C + 15 / DI,B - 53 / DI TO C + 8 / DI,B - 53 / DI TO C + 15 / DI,B - 68 / DI TO C + 8 / DI,B - 75 / DI TO C,B - 75 / DI
334 DRAW,C - 15 / DI,B - 68 / DI TO C + 15 / DI,B - 68 / DI: DRAW,C - 8 / DI,B - 53 / DI TO C + 8 / DI,B - 53 / DI: DRAW,C - 23 / DI,B - 15 / DI TO C + 8 / DI,B - 45 / DI
335 DRAW,C - 8 / DI,B - 68 / DI TO C,B - 60 / DI TO C + 8 / DI,B - 68 / DI TO C + 8 / DI,B - 60 / DI TO C - 8 / DI,B - 60 / DI TO C - 8 / DI,B - 68 / DI
336 DRAW,C,B - 38 / DI TO C - 8 / DI,B - 38 / DI TO C + 8 / DI,B - 53 / DI TO C + 8 / DI,B - 45 / DI TO C + 15 / DI,B - 45 / DI TO C,B - 30 / DI TO C,B - 38 / DI
339 GOTO 490
340 DRAW,C - 10 / DI,B - 15 / DI TO C - 10 / DI,B - 30 / DI TO C - 15 / DI,B - 20 / DI TO C - 15 / DI,B - 15 / DI TO C - 15 / DI,B TO C + 15/ DI,B TO C + 15 / DI,B - 15 / DI TO C - 15 / DI,B - 15 / DI
341 DRAW,C - 15 / DI,B - 10 / DI TO C + 15 / DI,B - 10 / DI: DRAW,C - 15 / DI,B - 5 / DI TO C + 15 / DI,B - 5 / DI
342 DRAW,C,B - 15 / DI TO C - 5 / DI,B - 20 / DI TO C - 5 / DI,B - 35 / DI TO C + 5 / DI,B - 35 / DI TO C + 5 / DI,B - 20 / DI TO C + 10 / DI,B - 15 / DI
343 DRAW,C - 5 / DI,B - 20 / DI TO C + 5 / DI,B - 20 / DI: DRAW,C - 5/ DI,B - 25 / DI TO C + 5 / DI,B - 25 / DI: DRAW,C - 5 / DI,B - 30/ DI TO C + 5 / DI,B - 30 / DI
344 DRAW,C - 10 / DI,B - 35 / DI TO C - 10 / DI,B - 40 / DI TO C - 5 / DI,B - 45 / DI TO C + 5 / DI,B - 45 / DI TO C + 10 / DI,B - 40 / DI TO C + 10 / DI,B - 35 / DI
345 DRAW,C - 10 / DI,B - 40 / DI TO C,B - 45 / DI TO C + 10 / DI,B - 40 / DI
346 DRAW,C - 5 / DI,B - 40 / DI TO C + 5 / DI,B - 40 / DI TO C + 15 / DI,B - 30 / DI TO C,B - 40 / DI TO C - 15 / DI,B - 30 / DI TO C - 5 / DI + .5,B - 40 / DI
349 GOTO 490
350 DRAW,C - 20 / DI,79 - YY%(DIS) TO C - 20 / DI,B - 88 / DI TO C - 10 / DI,B - 83 / DI TO C + 10 / DI,B - 83 / DI TO C + 20 / DI,B - 88 / DI TO C + 20 / DI,79 - YY%(DIS) TO C - 20 / DI,79 - YY%(DI)
351 DRAW,C - 20 / DI,B - 88 / DI TO C - 30 / DI,B - 83 / DI TO C - 30 / DI,B - 78 / DI: DRAW,C + 20 / DI,B - 88 / DI TO C + 30 / DI,B - 83 / DI TO C + 40 / DI,B - 83 / DI
352 DRAW,C - 15 / DI,B - 86 / DI TO C - 20 / DI,B - 83 / DI TO C - 20 / DI,B - 78 / DI TO C - 30 / DI,B - 73 / DI TO C - 30 / DI,B - 68 / DI TO C - 20 / DI,B - 63 / DI
353 DRAW,C - 10 / DI,B - 83 / DI TO C - 10 / DI,B - 58 / DI TO C,B - 50 / DI: DRAW,C + 10 / DI,B - 83 / DI TO C + 10 / DI,B - 78 / DI TO C + 20 / DI,B - 73 / DI TO C + 20 / DI,B - 40 / DI
354 DRAW,C + 15 / DI,B - 85 / DI TO C + 20 / DI,B - 78 / DI TO C + 30 / DI,B - 76 / DI TO C + 30 / DI,B - 60 / DI
355 DRAW,C,B - 83 / DI TO C,B - 73 / DI TO C + 10 / DI,B - 68 / DI TO C + 10 / DI,B - 63 / DI TO C,B - 58 / DI
359 GOTO 490
360 DRAW,C + 5 / DI + .5,B - 10 / DI TO C - 5 / DI + .5,B - 10 / DI TO C,B - 15 / DI TO C + 10 / DI,B - 20 / DI TO C + 5 / DI + .5,B - 15 / DI TO C + 5 / DI + .5,B - 10 / DI
361 DRAW TO C + 7 / DI + .5,B - 6 / DI TO C + 5 / DI + .5,B - 3 / DI TO C - 5 / DI + .5,B - 3 / DI TO C - 7 / DI + .5,B - 6 / DI TO C - 5 / DI + .5,B - 10 / DI
362 DRAW,C + 2 / DI + .5,B - 3 / DI TO C + 5 / DI + .5,B TO C + 8 / DI,B: DRAW,C - 2 / DI + .5,B - 3 / DI TO C - 5 / DI + .5,B TO C - 8 / DI,B: DRAW,C + 3 / DI + .5,B - 8 / DI: DRAW,C - 3 / DI + .5,B - 8 / DI: DRAW,C + 3 / DI + .5,B - 5 / DI TO C - 3 / DI + .5,B - 5 / DI
363 GOTO 490
370 DRAW,139 - 10 / DIS,PER%(DIS,3) TO 139 - 10 / DIS,PER%(DIS,3) - 10/ DIS TO 139 + 10 / DIS,PER%(DIS,3) - 10 / DIS TO 139 + 10 / DIS,PER%(DIS,3) TO 139 - 10 / DIS,PER%(DIS,3)
371 DRAW,139 - 10 / DIS,PER%(DIS,3) - 10 / DIS TO 139 - 5 / DIS,PER%(DIS,3) - 15 / DIS TO 139 + 15 / DIS,PER%(DIS,3) - 15 / DIS TO 139 + 15 / DIS,PER%(DIS,3) - 5 / DIS TO 139 + 10 / DIS,PER%(DIS,3)
372 DRAW,139 + 10 / DIS,PER%(DIS,3) - 10 / DIS TO 139 + 15 / DIS,PER%(DIS,3) - 15 / DIS
373 GOTO 490
380 DRAW,C - 14 / DI,B - 46 / DI TO C - 12 / DI,B - 37 / DI TO C - 20 / DI,B - 32 / DI TO C - 30 / DI,B - 32 / DI TO C - 22 / DI,B - 24 / DI TO C - 40 / DI,B - 17 / DI TO C - 40 / DI,B - 7 / DI TO C - 38 / DI,B - 5 / DI TO C - 40 / DI,B - 3 / DI TO C - 40 / DI,B
381 DRAW TO C - 36 / DI,B TO C - 34 / DI,B - 2 / DI TO C - 32 / DI,B TO C - 28 / DI,B TO C - 28 / DI,B - 3 / DI TO C - 30 / DI,B - 5 / DI TO C - 28 / DI,B - 7 / DI TO C - 28 / DI,B - 15 / DI TO C,B - 27 / DI
382 DRAW,C + 14 / DI,B - 46 / DI TO C + 12 / DI,B - 37 / DI TO C + 20 / DI,B - 32 / DI TO C + 30 / DI,B - 32 / DI TO C + 22 / DI,B - 24 / DI TO C + 40 / DI,B - 17 / DI TO C + 40 / DI,B - 7 / DI TO C + 38 / DI,B - 5 / DI TO C + 40 / DI,B - 3 / DI TO C + 40 / DI,B
383 DRAW TO C + 36 / DI,B TO C + 34 / DI,B - 2 / DI TO C + 32 / DI,B TO C + 28 / DI,B TO C + 28 / DI,B - 3 / DI TO C + 30 / DI,B - 5 / DI TO C + 28 / DI,B - 7 / DI TO C + 28 / DI,B - 15 / DI TO C,B - 27 / DI
384 DRAW,C+6/DI,B-48/DITOC+38/DI,B-41/DITOC+40/DI,B-42/DITOC+18/DI,B-56/DITOC+12/DI,B-56/DITOC+10/DI,B-57/DITOC+8/DI,B-56/DITOC-8/DI,B-56/DITOC-10/DI,B-58/DITOC+14/DI,B-58/DITOC+16/DI,B-59/DI
385 DRAWTOC+8/DI,B-63/DITOC+6/DI,B-63/DITOC+2/DI+.5,B-70/DITOC+2/DI+.5,B-63/DITOC-2/DI+.5,B-63/DITOC-2/DI+.5,B-70/DITOC-6/DI,B-63/DITOC-8/DI,B-63/DITOC-16/DI,B-59/DITOC-14/DI,B-58/DI
386 DRAWTOC-10/DI,B-57/DITOC-12/DI,B-56/DITOC-18/DI,B-56/DITOC-36/DI,B-47/DITOC-36/DI,B-39/DITOC-28/DI,B-41/DITOC-28/DI,B-46/DITOC-20/DI,B-50/DITOC-18/DI,B-50/DITOC-14/DI,B-46/DI
387 GOTO 3087
390 DRAW,C + 6 / DI,B - 60 / DI TO C + 30 / DI,B - 90 / DI TO C + 60 / DI,B - 30 / DI TO C + 60 / DI,B - 10 / DI TO C + 30 / DI,B - 40 / DI TO C + 15 / DI,B - 40 / DI
391 DRAW,C - 6 / DI,B - 60 / DI TO C - 30 / DI,B - 90 / DI TO C - 60 / DI,B - 30 / DI TO C - 60 / DI,B - 10 / DI TO C - 30 / DI,B - 40 / DI TO C - 15 / DI,B - 40 / DI
392 DRAW,C,B - 25 / DI TO C + 6 / DI,B - 25 / DI TO C + 10 / DI,B - 20/ DI TO C + 12 / DI,B - 10 / DI TO C + 10 / DI,B - 6 / DI TO C + 10/ DI,B TO C + 14 / DI,B TO C + 15 / DI,B - 5 / DI TO C + 16 / DI,B TO C + 20 / DI,B
393 DRAW TO C + 20 / DI,B - 6 / DI TO C + 18 / DI,B - 10 / DI TO C + 18 / DI,B - 20 / DI TO C + 15 / DI,B - 30 / DI TO C + 15 / DI,B - 45/ DI TO C + 40 / DI,B - 60 / DI TO C + 40 / DI,B - 70 / DI
394 DRAW TO C + 10 / DI,B - 55 / DI TO C + 6 / DI,B - 60 / DI TO C + 10 / DI,B - 74 / DI TO C + 6 / DI,B - 80 / DI TO C + 4 / DI + .5,B - 80 / DI TO C + 3 / DI + .5,B - 82 / DI TO C + 2 / DI + .5,B - 80 / DI TO C,B - 80 / DI
395 DRAW,C,B - 25 / DI TO C - 6 / DI,B - 25 / DI TO C - 10 / DI,B - 20/ DI TO C - 12 / DI,B - 10 / DI TO C - 10 / DI,B - 6 / DI TO C - 10/ DI,B TO C - 14 / DI,B TO C - 15 / DI,B - 5 / DI TO C - 16 / DI,B TO C - 20 / DI,B
396 DRAW TO C - 20 / DI,B - 6 / DI TO C - 18 / DI,B - 10 / DI TO C - 18 / DI,B - 20 / DI TO C - 15 / DI,B - 30 / DI TO C - 15 / DI,B - 45/ DI TO C - 40 / DI,B - 60 / DI TO C - 40 / DI,B - 70 / DI
397 DRAW TO C - 10 / DI,B - 55 / DI TO C - 6 / DI,B - 60 / DI TO C - 10 / DI,B - 74 / DI TO C - 6 / DI,B - 80 / DI TO C - 4 / DI + .5,B - 80 / DI TO C - 3 / DI + .5,B - 82 / DI TO C - 2 / DI + .5,B - 80 / DI TO C,B - 80 / DI
398 DRAW,C - 6 / DI,B - 25 / DI TO C,B - 6 / DI TO C + 10 / DI,B TO C + 4 / DI + .5,B - 8 / DI TO C + 6 / DI,B - 25 / DI: DRAW,C - 40 / DI,B - 64 / DI TO C - 40 / DI,B - 90 / DI TO C - 52 / DI,B - 80 / DI TO C - 52 / DI,B - 40 / DI
399 DRAW,C + 40 / DI,B - 86 / DI TO C + 38 / DI,B - 92 / DI TO C + 42 / DI,B - 92 / DI TO C + 40 / DI,B - 86 / DI TO C + 40 / DI,B - 50 / DI
400 DRAW,C + 4 / DI + .5,B - 70 / DI TO C + 6 / DI,B - 74 / DI: DRAW,C - 4 / DI + .5,B - 70 / DI TO C - 6 / DI,B - 74 / DI: DRAW,C,B - 64 / DI TO C,B - 60 / DI: GOTO 490
490 IF EN = 1 THEN EN = 0: RETURN
491 DIS = DIS + 1: GOTO 202
500 ZZ = RND(-ABS(LN) - TX*10 - TY*1000 + INOUT*31.4)
501 FOR X = 1 TO 9: FOR Y = 1 TO 9:DNG%(X,Y) = 0: NEXT : NEXT
510 FOR X = 0 TO 10:DNG%(X,0) = 1:DNG%(X,10) = 1:DNG%(0,X) = 1:DNG%(10,X) = 1: NEXT
520 FOR X = 2 TO 8 STEP 2: FOR Y = 1 TO 9:DNG%(X,Y) = 1:DNG(Y,X) = 1: NEXT : NEXT
530 FOR X = 2 TO 8 STEP 2: FOR Y = 1 TO 9 STEP 2
540 IF RND(1) > .95 THEN DNG%(X,Y) = 2
541 IF RND(1) > .95 THEN DNG%(Y,X) = 2
542 IF RND(1) > .6  THEN DNG%(Y,X) = 3
543 IF RND(1) > .6  THEN DNG%(X,Y) = 3
544 IF RND(1) > .6  THEN DNG%(X,Y) = 4
545 IF RND(1) > .6  THEN DNG%(Y,X) = 4
546 IF RND(1) > .97 THEN DNG%(Y,X) = 9
547 IF RND(1) > .97 THEN DNG%(X,Y) = 9
548 IF RND(1) > .94 THEN DNG%(X,Y) = 5
549 IF RND(1) > .94 THEN DNG%(Y,X) = 5
568 NEXT : NEXT
569 DNG%(2,1) = 0: IF INOUT / 2 =  INT (INOUT / 2) THEN DNG%(7,3) = 7:DNG%(3,7) = 8
570 IF INOUT / 2 <  >  INT (INOUT / 2) THEN DNG%(7,3) = 8:DNG%(3,7) = 7
580 IF INOUT = 1 THEN DNG%(1,1) = 8:DNG%(7,3) = 0
585 GOSUB 2000
590 RETURN
1000 WINDOW 0,19,28,24,0: SYSCM,,4,0: PRINT"{down}command? ";: POKE240,27: SYS49164,81
1001 GETX$: IF X$="" THEN 1001
1002 Q = FRE(0)
1010 X=ASC(X$):POKE 198,0
1030 IF X=79 OR X=145 THEN ON SGN(INOUT) + 1 GOTO 1100,1150: REM:NORTH:'O',UP
1040 IF X=76 OR X=29 THEN ON SGN(INOUT) + 1 GOTO 1200,1250: REM:EAST:'L',RIGHT
1050 IF X=75 OR X=157 THEN ON SGN(INOUT) + 1 GOTO 1300,1350: REM:WEST:'K'LEFT
1060 IF X=44 OR X=17 THEN ON SGN(INOUT) + 1 GOTO 1400,1450: REM:SOUTH:','DOWN
1070 IF X=88 THEN ON SGN(INOUT) + 1 GOTO 1500,1550: REM:ENTER:'X'
1080 IF X=65 THEN ON SGN(INOUT) + 1 GOTO 1600,1650: REM:ATTACK:'A'
1081 IF X=32 OR X=27 THEN PRINT"pass": GOTO 1090: REM:PASS:'SPACE',ESC
1085 IF X=83 THEN 1700: REM:STATS:'S'
1086 IF X=80 THEN IF PA = 1 THEN PA = 0: PRINT "pause off": GOTO 1000: REM:PAUSE ON/OFF:'P'
1087 IF X=80 THEN IF PA = 0 THEN PA = 1: PRINT "pause on": GOTO 1000
1089 PRINT"huh?": GOTO 1000
1090 PW(0) = PW(0) - 1 +  SGN(INOUT)*.9: IF PW(0)<0 THEN C(0) = 0: PRINT : PRINT "you have starved!!!!!": GOTO 1093
1091 WINDOW 29,19,39,24: SYSCM,,2,0: PRINT "food=";PW(0);: POKE240,27:SYS49164,81: SYSCM,,3,0: PRINT "h.p.=";C(0);: POKE240,27:SYS49164,81: SYSCM,,4,0: PRINT "gold=";C(5);: POKE240,27:SYS49164,81
1092 PW(0) =  INT(PW(0)*10) / 10
1093 IF C(0) <= 0 THEN 6000
1095 IF IN > 0 THEN WINDOW 0,19,28,24,0: SYSCM,,4,0: GOSUB 4000: IF C(0) <= 0 THEN 1093
1096 WINDOW 29,19,39,24: SYSCM,,2,0: PRINT "food=";PW(0);: POKE240,27:SYS49164,81: SYSCM,,3,0: PRINT "h.p.=";C(0);: POKE240,27:SYS49164,81: SYSCM,,4,0: PRINT "gold=";C(5);: POKE240,27:SYS49164,81
1097 IF INOUT = 0 THEN WINDOW 0,0,39,19: GOSUB 100: GOTO 1000
1098 IF INOUT > 0 THEN WINDOW 0,0,39,19: GOSUB 200: GOTO 1000
1100 PRINT "north": IF TER%(TX,TY - 1) = 1 THEN PRINT "you can't pass the mountains": GOTO 1090
1110 TY = TY - 1: GOTO 1090
1150 IF DNG%(PX + DX,PY + DY)<>1 AND DNG%(PX + DX,PY + DY)<10 THEN PX = PX + DX:PY = PY + DY
1155 PRINT "forward"
1160 IF DNG%(PX,PY)=2 THEN PRINT "aaarrrggghhh!!! a trap!":C(0)= C(0) - INT(RND(1)*INOUT+3):MR = 1:INOUT = INOUT + 1: PRINT "falling to level ";IN: GOSUB 500: GOTO 1090
1165 Z = 0
1170 IF DNG%(PX,PY)=5 THEN DNG%(PX,PY)=0: PRINT "gold!!!!!":Z = INT(RND(1)*5*INOUT+INOUT): PRINT Z;"-pieces of eight":C(5) = C(5) + Z
1175 IF Z > 0 THEN Z = INT(RND(1)*6): PRINT "and a ";W$(Z):PW(Z) = PW(Z) + 1: GOTO 1090
1190 GOTO 1090
1200 PRINT "east": IF TER%(TX + 1,TY) = 1 THEN  PRINT "you can't pass the mountains": GOTO 1090
1210 TX = TX + 1: GOTO 1090
1250 PRINT "turn right"
1255 IF DX<>0 THEN DY = DX: DX = 0: GOTO 1090
1260 DX = - DY:DY = 0: GOTO 1090
1300 PRINT "west": IF TER%(TX - 1,TY) = 1 THEN PRINT "you can't pass the mountains": GOTO 1090
1310 TX = TX - 1: GOTO 1090
1350 PRINT "turn left{down}"
1355 IF DX<>0 THEN DY = -DX: DX = 0: GOTO 1090
1360 DX = DY: DY = 0: GOTO 1090
1400 PRINT "south": IF TER%(TX,TY + 1) = 1 THEN  PRINT "you can't pass the mountains": GOTO 1090
1410 TY = TY + 1: GOTO 1090
1450 PRINT "turn around": DX = -DX: DY = -DY: GOTO 1090
1500 IF TE%(TX,TY) = 3 THEN GOSUB 60080: GOSUB 60200: GOTO 1090
1510 IF TE%(TX,TY) = 4 AND INOUT = 0 THEN PRINT "go dungeon": PRINT "please wait ":INOUT = 1: GOSUB 500: DX = 1: DY = 0: PX = 1: PY = 1: GOTO 1090
1515 IF TE%(TX,TY) = 5 THEN 7000
1520 PRINT "huh?": GOTO 1000
1550 IF DNG%(PX,PY)<>7 AND DNG%(PX,PY)<>9 THEN 1580
1555 PRINT "go down to level ";INOUT + 1
1560 INOUT = INOUT + 1: GOSUB 500: MR = 1: GOTO 1090
1580 IF DNG%(PX,PY)<>8 THEN PRINT "huh?{down}": GOTO 1090
1581 IF IN = 1 THEN PRINT "leave dungeon":IN = 0: GOTO 1586
1584 PRINT "go up to level ";INOUT - 1
1585 INOUT = INOUT - 1: GOSUB 500: MR = 1
1586 IF IN = 0 THEN PRINT "thou hast gained": PRINT LK;" hit points{down}": C(0) = C(0) + LK: LK = 0
1587 GOTO 1090
1600 GOTO 1090
1650 MN = 0: DAM = 0: PRINT "attack": PRINT "which weapon ";: DO:GET Q$:LOOP WHILE Q$=""
1651 IF Q$ = "r" THEN DAM = 10: PRINT "rapier": IF PW(1) < 1 THEN  PRINT "not owned": GOTO 1650
1652 IF Q$ = "a" THEN DAM = 5: PRINT "axe": IF PW(2) < 1 THEN  PRINT "not owned": GOTO 1650
1653 IF Q$ = "s" THEN DAM = 1: PRINT "shield": IF PW(3) < 1 THEN  PRINT "not owned": GOTO 1650
1654 IF Q$ = "b" THEN DAM = 4: PRINT "bow": IF PW(4) < 1 THEN  PRINT "not owned": GOTO 1650
1655 IF Q$ = "m" THEN PRINT "magic amulet": GOTO 1680
1656 IF Q$ = "b" AND PT$ = "m" THEN  PRINT "mages can't use bows!": GOTO 1650
1657 IF Q$ = "r" AND PT$ = "m" THEN  PRINT "mages can't use rapiers!": GOTO 1650
1659 IF DAM = 0 THEN  PRINT "hands"
1660 IF DAM = 5 OR DAM = 4 THEN 1670
1661 MN = DN%(PX + DX,PY + DY) / 10:MN = INT(MN)
1662 IF MN < 1 OR C(2) - RND(1)*25 < MN + INOUT THEN  PRINT "you missed": GOTO 1668
1663 PRINT "hit!!! ": DAM=(RND(1)*DAM + C(1) / 5):MZ%(MN,1) = MZ%(MN,1) - DAM
1664 PRINT M$(MN);"'s hit points=";MZ%(MN,1)
1665 IF MZ%(MN,1) < 1 THEN PRINT "thou hast killed a ";M$(MN): PRINT "thou shalt receive":DA = INT(MN + IN): PRINT DA;" pieces of eight"
1666 IF MZ%(MN,1) < 1 THEN C(5)=INT(C(5) + DA):DNG%(ML%(MN,0),ML%(MN,1)) = DNG%(ML%(MN,0),ML%(MN,1)) - 10 * MN:MZ%(MN,0) = 0
1667 LK = LK + INT(MN * IN / 2): IF MN = TASK THEN TASK = -TASK
1668 IF PA = 1 THEN  PRINT "[return] to cont. ";: POKE 198,0: INPUT Q$
1669 GOTO 1090
1670 IF DAM = 5 THEN PRINT "to throw or swing:";: DO:GET Q$:LOOP WHILE Q$="": IF Q$ <> "t" THEN PRINT "swing": GOTO 1661
1671 IF DAM = 5 THEN PRINT "throw": PW(2) = PW(2) - 1
1672 FOR Y = 1 TO 5: IF PX + DX * Y < 1 OR PX + DX * Y > 9 OR PY + DY * Y > 9 OR PY + DY * Y < 0 THEN 1662
1673 MN = DNG%(PX + DX * Y,PY + DY * Y):MN = INT(MN / 10): IF MN > 0 THEN 1662
1674 NEXT : GOTO 1662
1680 IF PW(5)<1 THEN  PRINT "none owned": GOTO 1650
1681 IF PT$ = "f" THEN Q = INT(RND(1)*4 + 1): GOTO 1685
1682 PRINT "1-ladder-up","2-ladder-dn": PRINT "3-kill","4-bad??": PRINT "choice ";:DO:GET Q$:LOOP WHILE Q$="": Q = VAL(Q$): PRINT Q: IF Q < 1 OR Q > 4 THEN 1682
1683 IF RND(1)>.75 THEN PRINT "last charge on this amulet!":PW(5) = PW(5) - 1
1685 ON Q GOTO 1686,1690,1691,1692
1686 PRINT "ladder up": DNG%(PX,PY) = 8: GOTO 1090
1690 PRINT "ladder down": DNG%(PX,PY) = 7: GOTO 1090
1691 PRINT "magic attack": DAM = 10 + INOUT: GOTO 1672
1692 ON INT(RND(1)*3 + 1) GOTO 1693,1695,1697
1693 PRINT "you have been turned": PRINT "into a toad!"
1694 FOR Z2 = 1 TO 4: C(Z2) = 3: NEXT Z2: GOTO 1090
1695 PRINT "you have been turned": PRINT "into a lizard man": FOR Y = 0 TO 4:C(Y) =  INT (C(Y) * 2.5): NEXT : GOTO 1090
1697 PRINT "backfire": C(0) = C(0) / 2: GOTO 1090
1700 GOSUB 60080:PRINT "press return to continue";:POKE198,0
1710 GET X$:IF X$<>CHR$(13) THEN 1710
1720 SCNCLR:GRAPHIC 0,1: WINDOW 0,0,39,24: GOTO 1090
2000 NM = 0: FOR X = 1 TO 10
2005 MZ%(X,0) = 0:MZ%(X,1) = X + 3 + INOUT
2010 IF X - 2 > INO OR RND(1)>.4 THEN 2090
2020 ML%(X,0) =  INT(RND(1)*9 + 1): ML%(X,1) = INT(RND(1)*9 + 1)
2030 IF DNG%(ML%(X,0),ML%(X,1)) <> 0 THEN 2020
2040 IF ML%(X,0) = PX AND ML%(X,1) = PY THEN 2020
2050 DNG%(ML%(X,0),ML%(X,1)) = X * 10
2051 MZ%(X,0) = 1
2052 NM = NM + 1
2055 MZ%(X,1) = X * 2 + IN * 2 * LP
2090 NEXT : RETURN
3087 DRAW,C - 28 / DI,B - 41 / DI TO C + 30 / DI,B - 55 / DI: DRAW,C + 28 / DI,B - 58 / DI TO C + 22 / DI,B - 56 / DI TO C + 22 / DI,B - 53/ DI TO C + 28 / DI,B - 52 / DI TO C + 34 / DI,B - 54 / DI: DRAW,C+ 20 / DI,B - 50 / DI TO C + 26 / DI,B - 47 / DI
3088 DRAW,C + 10 / DI,B - 58 / DI TO C + 10 / DI,B - 61 / DI TO C + 4 / DI,B - 58 / DI: DRAW,C - 10 / DI,B - 58 / DI TO C - 10 / DI,B - 61 / DI TO C - 4 / DI,B - 58 / DI: DRAW,C + 40 / DI,B - 9 / DI TO C + 50/ DI,B - 12 / DI TO C + 40 / DI,B - 7 / DI
3089 DRAW,C - 8 / DI,B - 25 / DI TO C + 6 / DI,B - 7 / DI TO C + 28 / DI,B - 7 / DI TO C + 28 / DI,B - 9 / DI TO C + 20 / DI,B - 9 / DI TO C + 6 / DI,B - 25 / DI: GOTO 490
4000 FOR MM = 1 TO 10: IF MZ%(MM,0) = 0 THEN 4999
4010 RA = SQR((PX - ML%(MM,0)) ^ 2 + (PY - ML%(MM,1)) ^ 2)
4011 IF MZ%(MM,1) < IN * LP THEN 4030
4020 IF RA < 1.3 THEN 4500
4025 IF MM = 8 AND RA < 3 THEN 4999
4030 X1 = SGN(PX - ML%(MM,0)):Y1 = SGN(PY - ML%(MM,1))
4031 IF MZ%(MM,1) < IN * LP THEN X1 =  - X1: Y1 =  - Y1
4035 IF Y1 = 0 THEN 4045
4040 D = DNG%(ML%(MM,0),(ML%(MM,1) + Y1 + .5)): IF D = 1 OR D > 9 OR D = 2 THEN 4045
4042 X1 = 0: GOTO 4050
4045 Y1 = 0: IF X1 = 0 THEN 4050
4046 D = DN%((ML%(MM,0) + X1 + .5),ML%(MM,1)): IF D = 1 OR D > 9 OR D = 2 THEN X1 = 0: GOTO 4081
4050 DNG%(ML%(MM,0),ML%(MM,1)) = DNG%(ML%(MM,0),ML%(MM,1)) - 10 * MM
4055 IF ML%(MM,0) + X1 = PX AND ML%(MM,1) + Y1 = PY THEN 4999
4060 ML%(MM,0) = ML%(MM,0) + X1:ML%(MM,1) = ML%(MM,1) + Y1
4080 DNG%(ML%(MM,0),ML%(MM,1)) = (DNG%(ML%(MM,0),ML%(MM,1)) + 10 * MM + .5)
4081 IF X1 <> 0 OR Y1 <> 0 THEN 4999
4082 IF MZ%(MM,1) < IN * LP AND RA < 1.3 THEN 4500
4083 IF MZ%(MM,1) < IN * LP THEN MZ%(MM,1) = MZ%(MM,1) + MM + IN
4499 GOTO 4999
4500 IF MM = 2 OR MM = 7 THEN 4600
4509 PRINT "you are being attacked": PRINT "by a ";M$(MM)
4510 IF RND(1)*20 - SGN(PW(3)) - C(3) + MM + IN < 0 THEN PRINT "missed": GOTO 4525
4520 PRINT "hit": C(0) = C(0) - INT(RND(1)*MM + IN)
4525 IF PA = 1 THEN PRINT "-return- to cont. ";: POKE 198,0: INPUT Q$
4530 GOTO 4999
4600 IF RND(1) < .5 THEN 4509
4610 IF MM = 7 THEN PW(0) = INT(PW(0) / 2): PRINT "a gremlin stole some food": GOTO 4525
4620 ZZ = INT(RND(1)*6): IF PW(ZZ) < 1 THEN 4620
4630 PRINT "a thief stole a ";W$(ZZ): PW(ZZ) = PW(ZZ) - 1: GOTO 4525
4999 NEXT : RETURN
6000 WINDOW 0,19,39,24: PRINT : PRINT : PRINT "{space*8}we mourn the passing of"
6005 IF  LEN (PN$) > 22 THEN PN$ = ""
6010 IF PN$ = "" THEN PN$ = "the peasant"
6020 PN$ = PN$ + " and his computer"
6030 print TAB (19 -  INT(LEN(PN$) / 2));PN$
6035 PRINT "{space*2}to invoke a miracle of ressurection"
6040 PRINT "{space*13}<hit esc key>";
6050 DO: GET Q$: LOOP WHILE Q$="": IF ASC(Q$)=27 THEN 1
6060 GOTO 6050
7000 GRAPHIC 0: WINDOW 0,0,39,24,1
7010 IF PN$ <> "" THEN 7500
7020 PRINT : PRINT : PRINT "{space*5}welcome peasant into the halls of": PRINT "the mighty lord british. herein thou maychoose to dare battle with the evil": PRINT "creatures of the depths, for great": PRINT "reward!"
7030 PRINT : PRINT "what is thy name peasant ";: POKE 198,0: INPUT PN$
7040 PRINT "doest thou wish for grand adventure ? ";:DO: GET Q$: LOOP WHILE Q$="": IF Q$ <> "y" THEN  PRINT : PRINT "then leave and begone!":PN$ = "": PRINT : PRINT "{space*9}press -space- to cont.";: DO: GET Q$: LOOP WHILE Q$="": GOTO 1090
7045 PRINT
7050 PRINT : PRINT "good! thou shalt try to become a ": PRINT "knight!!!": PRINT : PRINT "thy first task is to go into the": PRINT "dungeons and to return only after": PRINT "killing a(n) ";:TASK =  INT (C(4) / 3): PRINT M$(TASK)
7060 PRINT : PRINT "{space*5}go now upon this quest, and may": PRINT "lady luck be fair unto you.....": PRINT ".....also i, british, have increased": PRINT "each of thy attributes by one!"
7070 PRINT : PRINT "{space*9}press -space- to cont.";: DO:GET Q$:LOOP WHILE Q$<>" ": FOR X = 0 TO 5:C(X) = C(X) + 1: NEXT : GRAPHIC 2,1,20 : GOTO 1090
7500 IF TASK > 0 THEN  PRINT : PRINT : PRINT PN$;" why hast thou returned?": PRINT "thou must kill a(n) ";M$(TASK): PRINT "go now and complete thy quest!": PRINT : PRINT "{space*9}press -space- to cont.";: DO: GET Q$: LOOP WHILE Q$="": SCNCLR : GOTO 1090
7510 PRINT : PRINT : PRINT : PRINT "aahh!!.....";PN$: PRINT : PRINT "thou hast acomplished thy quest!": IF ABS(TASK) = 10 THEN 7900
7520 PRINT "unfortunately, this is not enough to": PRINT "become a knight.":TASK = ABS(TASK) + 1: PRINT : PRINT "now thou must kill a(n) ";M$(TASK)
7530 GOTO 7060
7900 GRAPHIC 0: WINDOW 0,0,39,24,1: PRINT : PRINT : PRINT :PN$ = "lord " + PN$: PRINT " ";PN$;","
7910 PRINT "{space*7}thou hast proved thyself worthy": PRINT "of knighthood, continue play if thou": PRINT "doth wish, but thou hast acomplished": PRINT "the main objective of this game..."
7920 IF LP = 10 THEN 7950
7930 PRINT : PRINT "{space*3}now maybe thou art foolhearty": PRINT "enough to try difficulty level ";LP + 1
7940 GOTO 7070
7950 PRINT : PRINT "...call california pacific computer": PRINT "at (415)-569-9126 to report this": PRINT "amazing feat!"
7990 GOTO 7070
60000 SYSCM,,4,0: INPUT "type thy lucky number.....";Q$: LN = VAL(Q$)
60005 SYSCM,,6,0: INPUT"level of play (1-10)......";Q$: LP = INT(VAL(Q$))
60006 IF LP < 1 OR LP > 10 THEN 60005
60010 ZZ = RND(-ABS(LN))
60020 DATA "hit points.....","strength.......","dexterity......","stamina........","wisdom.........","gold..........."
60025 DIM PW(5)
60030 DIM C$(5): FOR X = 0 TO 5: READ C$(X): NEXT
60040 DIM C(5)
60041 DIM M$(10),ML%(10,1),MZ%(10,1)
60042 DATA "skeleton","thief","giant rat","orc","viper","carrion crawler","gremlin","mimic","daemon","balron"
60043 FOR X = 1 TO 10: READ M$(X): NEXT
60050 FOR X = 0 TO 5:C(X) =  INT(SQR(RND(1))*21+4): NEXT X
60060 SCNCLR: SYSCM,,7,0: FOR X = 0 TO 5: PRINT C$(X),C(X): NEXT : PRINT : PRINT "shalt thou play with these qualities?": PRINTTAB(19): DO:GETQ$:LOOPWHILEQ$="": IF Q$ <> "y" THEN 60050
60061 SYSCM,,14,0: PRINT : PRINT "and shalt thou be a fighter or a mage?": PRINTTAB(19): DO:GETPT$:LOOPWHILEPT$=""
60062 IF PT$ = "m" OR PT$ = "f" THEN 60070
60063 GOTO 60061
60070 DIM W$(5): DATA "food","rapier","axe","shield","bow and arrows","magic amulet": FOR X = 0 TO 5: READ W$(X): NEXT
60075 GOSUB 60080: GOSUB 60200: RETURN
60080 GRAPHIC 0,1: WINDOW 0,0,39,24,1: PRINT : PRINT : PRINT"{space*5}stat's{space*14}weapons": PRINT : FOR X = 0 TO 5: PRINT C$(X);C(X);TAB(23);"0-";W$(X): NEXT
60081 SYSCM,,10,17: PRINT "q-quit"
60085 FOR Z = 0 TO 5: SYSCM,,4+Z,24 - LEN(STR$(PW(Z))): PRINT PW(Z);: NEXT
60090 SYSCM,,16,4: PRINT "price";: PRINTTAB(14)"damage";TAB(24)"item"
60100 FOR X = 0 TO 5: SYSCM,,18 + X,24: PRINT W$(X): NEXT
60110 SYSCM,,18,4: PRINT "1 for 10"TAB(14)"n/a": SYSCM,,19,4: PRINT "8"TAB(14)"1-10": SYSCM,,20,4: PRINT "5"TAB(14)"1-5"
60120 SYSCM,,21,4: PRINT "6"TAB(14)"1": SYSCM,,22,4: PRINT "3"TAB(14)"1-4": SYSCM,,23,4: PRINT "15"TAB(14)"?????"
60130 RETURN
60200 SYSCM,,11,0: PRINT "welcome to the adventure shop":WINDOW 0,12,39,15,1:PRINT"{down*2}"
60210 PRINT "which item shalt thou buy ";:DO: GET Q$: LOOPWHILEQ$="": IF Q$ = "q" THEN  PRINT : PRINT "bye": SLEEP 2 : WINDOW 0,0,39,24,1: RETURN
60215 Z = -1
60220 IF Q$ = "f" THEN PRINT "food":  Z = 0:P = 1
60221 IF Q$ = "r" THEN PRINT "rapier":Z = 1:P = 8
60222 IF Q$ = "a" THEN PRINT "axe":   Z = 2:P = 5
60223 IF Q$ = "s" THEN PRINT "shield":Z = 3:P = 6
60224 IF Q$ = "b" THEN PRINT "bow":   Z = 4:P = 3
60225 IF Q$ = "m" THEN PRINT "amulet":Z = 5:P = 15
60226 IF Z = -1 THEN PRINT Q$: PRINT "i'm sorry we don't have that.": GOTO 60210
60227 IF Q$ = "r" AND PT$ = "m" THEN PRINT "i'm sorry mages": PRINT "can't use that!": GOTO 60210
60228 IF Q$ = "b" AND PT$ = "m" THEN PRINT "i'm sorry mages": PRINT "can't use that!": GOTO 60210
60230 IF C(5) - P < 0 THEN PRINT "m'lord thou can not afford that item.": GOTO 60210
60235 IF Z = 0 THEN PW(Z) = PW(Z) + 9
60236 PW(Z) = PW(Z) + 1:C(5) = C(5) - P
60237 WINDOW 0,0,39,24: SYSCM,,9,15: PRINT C(5);"{left}{space*2}"
60240 SYSCM,,4 + Z,24 - LEN(STR$(PW(Z))): PRINT PW(Z);: SYSCM,,0,13: PRINT
60250 WINDOW 0,12,39,15:PRINT"{down*2}":GOTO 60210
