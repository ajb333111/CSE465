/*
           QUADRATIC

The real roots of Ax^2+Bx+C=0 are returned in the list named ROOTS. If there are
two roots, they are arranged in ascending order.

Successful queries:
 quadratic(2,5,2,[-2,-0.5]).     
 quadratic(1,2,1,[-1.0]).
 quadratic([1,2,1], X).    % binds X to [-1.0]

Unsuccessful queries:
 quadratic(3,0,-4,X).      % fails because no real roots
*/

quadratic(LST, ROOTS) :- LST = ROOTS.  
quadratic(A, B, C, ROOTS) :- S is (B*B - 4*A*C)^(1/2), S > 0.0, M is (-B - S) / (2*A), P is (-B + S) / (2*A), quadratic([M, P], ROOTS).
quadratic(A, B, C, ROOTS) :- S is (B*B - 4*A*C)^(1/2), S = 0.0, P is (-B + S) / (2*A), quadratic([P], ROOTS).

/*
          MAX3

The first three parameters are bound numbers. The last parameter is a bound number
or a variable. The result is that last parameter is bound to the maximum of the three
numbers.

Successful queries:
 max3(1,2,3,3).     
 max3(1,2,3,X).     % X bound to 3

Unsuccessful queries:
 max3(1,2,3,0).     
*/

max3(X, MAX) :- X = MAX.
max3(A, B, C, MAX) :- A > B, A > C, max3(A, MAX).
max3(A, B, C, MAX) :- B > A, B > C, max3(B, MAX).
max3(A, B, C, MAX) :- C > A, C > B, max3(C, MAX).

/*
          ISSORTED

The parameter is a flat list of numbers. The rule succeeds if the number are in
ascending order.

Successful queries:
 isSorted([1,2,2]).     
 isSorted([]).

Unsuccessful queries:
 isSorted([1,2,1]).     
 isSorted([1,2,3,4,3,6,7]).
*/

isSorted([]).
isSorted([A, B]) :- B > A.
isSorted(LST) :- LST = [H1|T],T = [H2|S], H2 > H1, isSorted(T).

/*
         MAXOFLIST

The first parameter is a bound, flat, list of numbers. The second parameter corresponds
to the maximum value of the list. The query fails if the list is empty.

Successful queries:
 maxOfList([1,9,2,2], 9).     
 maxOfList([1,9,2,2], X).     % X bound to 9
 maxOfList([1], 1).

Unsuccessful queries:
 maxOfList([], 0).     
 maxOfList([1,2,3,4,3,6,7], 1).
*/

maxOfList([], MAX) :- fail.
maxOfList([A], MAX) :- A = MAX.
maxOfList(LST, MAX) :- LST = [H1,H2|T], H2 >= H1, maxOfList([H2|T], MAX).
maxOfList(LST, MAX) :- LST = [H1,H2|T], H1 >= H2, maxOfList([H1|T], MAX).

/*
          SUMMATION

The first parameter is a flat list of numbers. The last parameter corresponds to the
summation of all of the numbers.

Sample successful queries:
 summation([1,2,2], 5).     
 summation([], 0).
 summation([1,2,2], X).     % X bound to 5

Sample unsuccessful queries:
 summation([1,2,1], 10).     
*/

summation([], SUM) :- SUM is 0.
summation([X], SUM) :- SUM is X.
summation([A, B], SUM) :- SUM is A + B.
summation(LST, SUM) :- LST = [H1,H2|T], L is H1 + H2, summation([L|T], SUM).

/*
           REMOVEKTH

The first parameter is a bound integer K. The second paramter is a abound list. The
third parameter is the same as the original list, but with the kth element removed,
where numbering starts at 1. The query fails if k is an invalid number.

Successful queries:
 removeKth(1, [a,b,c,d], [b,c,d]).
 removeKth(1, [a,b,c,d], L).		% binds L to [b,c,d]
 removeKth(3, [a,b,c,d], L).		% binds L to [a,b,d]

Unsuccessful queries:
 removeKth(10, [a,b,c,d], L).
 removeKth(0, [a,b,c,d], L).
 removeKth(-2, [a,b,c,d], L).
*/

removeKth(T, NEWLST) :- T = NEWLST.
removeKth(K, LST, NEWLST) :- K = 1, LST = [_|T], removeKth(T, NEWLST).
removeKth(K, LST, NEWLST) :- K = 2, LST = [H1,_|T], removeKth([H1|T], NEWLST).
removeKth(K, LST, NEWLST) :- K = 3, LST = [H1,H2,_|T], removeKth([H1,H2|T], NEWLST).
removeKth(K, LST, NEWLST) :- K = 4, LST = [H1,H2,H3,_|T], removeKth([H1,H2,H3|T], NEWLST).

/*
         SPLITABLE

Succeeds if the list of integers can be cleved into two sublists that both sum to
the same value.

Successful queries:
 splitable([1,2,3,4,10]).
 splitable([2,1,1]).
 splitable([0]).

Unsuccessful queries:
 splitable([1,4,8]).
 splitable([1,3,2]).
 splitable([2,2,1,1]).
*/

splitable(F, LST) :- LST = [H1|T], summation([H1|F], X), summation(T, Y), X \= Y, splitable([H1|F], T).
splitable(F, LST) :- LST = [H1|T], summation([H1|F], X), summation(T, Y), X = Y.
splitable(LST) :- LST = [H1|T], summation([H1|[]], X), summation(T, Y), X \= Y, splitable([H1], T).
splitable(LST) :- LST = [H1|T], summation([H1|[]], X), summation(T, Y), X = Y.
 

/*
        DOMINOS

Each domino is unique and is oriented left to right, but can be flipped. So, the domino
3-4 can appear as 4-3. The dominos in this particular rendition of the game are:
         1-4  4-2  9-8  7-8  15-7  10-12  2-12  10-4
These dominos are shown below. When you submit, the dominos must appear as they are
originally given to you.
*/

dom(1, 4).
dom(4, 2).
dom(9, 8).
dom(7, 8).
dom(15, 7).
dom(10, 12).
dom(2, 12).
dom(10, 4).

dom(100, 101).

dom(50, 51).
dom(52, 51).
dom(53, 52).
dom(55, 54).
dom(55, 55).
dom(54, 56).
dom(56, 53).
dom(55, 60).
dom(55, 61).
dom(60, 51).

/*
The dominos can be sequenced if the numbers on the adjacent dominos match. For example,
here is a legal sequence of three dominos: 4-2 2-12 12-10
The game is played by determining if a sequence of dominos exist that start and end with
particular values. For example, there exists a sequence of dominos that start with 4 and
end with 10. Write a rule that succeeds if a sequence exists. The dominos can be used
at most once in a sequence.

Successful queries:
 dominos(4, 10).
 dominos(10, 4).
 dominos(15, 7).
 dominos(7, 9).

Unsuccessful queries:
 dominos(1, 15).
 dominos(15, 1).
*/

dominos(START, END) :- dom(START, END). 
dominos(START, END) :- dom(START, X), dominos(X, END).
dominos(START, END) :- dom(X, START), X = END.

/*
       MTH COUSINS N TIMES REMOVED

Here are the parental relationships (see Google Docs file "GenerationNames").
The abbreviations used are based on females:
         D = daughther, A = aunt, N = niece, M = mother
So, ggm corresponds to great-grandmother. gn corresponds to great niece.
When you submit, the family relationships must appear exactly as the are originally
given to you.
*/

parent(gggm, ggm).
parent(ggm, gm).
parent(gm, m).
parent(m, self).
parent(self, d).
parent(d, gd).

parent(gggm, gga). parent(gga, c12a). parent(c12a, c21a). parent(c21a, c3).
parent(ggm, ga). parent(ga, c11a). parent(c11a, c2).
parent(gm, a). parent(a, c1).

parent(m, s).

parent(s, n). parent(n, gn).
parent(c1, c11b). parent(c11b, c12b).

parent(c2, c21b). parent(c21b, c22).
parent(c3, c31). parent(c31, c32).

/*
Succeeds if P1 and P2 are Mth cousins N times removed.
M and N must be bound to integers when the query is issued.

Successful queries:
 mthCousinNTimesRemoved(self, c3, 3, 0).
 mthCousinNTimesRemoved(self, c31, 3, 1).
 mthCousinNTimesRemoved(self, c32, 3, 2).

 mthCousinNTimesRemoved(self, c2, 2, 0).
 mthCousinNTimesRemoved(self, c21a, 2, 1).
 mthCousinNTimesRemoved(self, c21b, 2, 1).
 mthCousinNTimesRemoved(self, c22, 2, 2).

 mthCousinNTimesRemoved(self, c1, 1, 0).
 mthCousinNTimesRemoved(self, c11a, 1, 1).
 mthCousinNTimesRemoved(self, c11b, 1, 1).
 mthCousinNTimesRemoved(self, c12a, 1, 2).
 mthCousinNTimesRemoved(self, c12b, 1, 2).

 mthCousinNTimesRemoved(c1, c2, 2, 0).
 mthCousinNTimesRemoved(c2, c1, 2, 0).
 mthCousinNTimesRemoved(c11b, c32, 3, 1).
 mthCousinNTimesRemoved(c32, c11b, 3, 1).

Sample unsuccessful queries:
 mthCousinNTimesRemoved(self, gn, 1, 2).
 mthCousinNTimesRemoved(self, s, 1, 0).
 mthCousinNTimesRemoved(gd, ggm, 1, 1).
*/

mthCousinNTimesRemoved(P1, P2, M, N) :- fail.

/*
         SENTENCE 

This problem is exactly as described in the "parse.pl" code. The difference here is 
that the number (i.e., plurality) of the noun phrase and verb phrase must match. That
is, "The sun shines" and "The suns shine" is proper, whereas "The suns shines" and
"The sun shine" are not. Make sure your code includes the following vocabulary:

singular nouns:    sun, bus, deer
plural nouns:      suns, buses, deer
articles:          a, an, the
adverbs:           loudly, brightly
adjectives:        yellow, big, brown
plural verbs:      shine, run, eat
singular verbs:    shines, runs, eats

Successful queries:
 sentence([the, sun, shines]).	
 sentence([the, yellow, sun, shines]).	
 sentence([the, yellow, suns, shine]).
	
Unsuccessful queries:
 sentence([the, yellow, suns, shines]).
 sentence([the, yellow, sun, shine]).
*/
nounS([sun]).
nounS([bus]).
nounS([deer]).
nounP([deer]).
nounP([suns]).
nounP([buses]).
articleS([a]).
articleSV([an]).
article([the]).
adverb([loudly]).
adverb([brightly]).
adjective([yellow]).
adjective([big]).
adjective([brown]).
verbS([shines]).
verbS([runs]).
verbS([eats]).
verbP([shine]).
verbP([run]).
verbP([eat]).

sentence(S) :- append(NP, VP, S), np(NP, N), vp(VP, N).

np([ART|NP], N) :- articleS([ART]), N = 1, np2(NP, N).
np([ART|NP], N) :- article([ART]), np2(NP, N).
np(NP, N) :- np2(NP, N).

np2(NP2, N) :- N is 1, nounS(NP2).
np2(NP2, N) :- nounS(NP2), N = 1.
np2(NP2, N) :- nounP(NP2), N = 2.
np2([ADJ|NP2], N) :- adjective([ADJ]), np2(NP2, N).

vp(VP, N) :- N is 1, verbS(VP).
vp(VP, N) :- N is 2, verbP(VP).
vp([VERB|ADV], N) :- N is 1, verbS([VERB]), adverb(ADV).
vp([VERB|ADV], N) :- N is 2, verbP([VERB]), adverb(ADV). 


