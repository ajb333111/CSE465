; NO OUTPUT SHOULD BE PRODUCED IN THIS FILE

(define (sortQuad lst)
  (if (< (car lst) (cadr lst))
    lst
    (list (cadr lst) (car lst)) 
    )
  )
; Returns the roots of the quadratic formula, given
; ax^2+bx+c=0. Return only real roots. The list will
; have 0, 1, or 2 roots. The list of roots should be
; sorted in ascending order.
; a is guaranteed to be non-zero.
; Use the quadratic formula to solve this.
; (quadratic 1 0 0) --> (0)
; (quadratic 1 2 5) --> ()
; (quadratic 1 3 -4) --> (-4.0 1.0)
(define (quadratic a b c)
  (cond 
    ( (< (- (expt b 2) (* 4 a c)) 0 )'() )
    ( (= (- (expt b 2) (* 4 a c)) 0 ) (list(/ (- 0 b) (* 2 a)) ))
    ( (= b 0 ) (list (/ (sqrt (- (expt b 2) (* 4 a c))) (* 2 a)) ))
 	
    (else (sortQuad(list (/ (+ (- 0 b) (sqrt (- (expt b 2) (* 4 a c)))) (* 2 a)) (/ (- (- 0 b) (sqrt (- (expt b 2) (* 4 a c)))) (* 2 a)) ) ))
	)
)
; Returns the fewest number of minutes between two times, where the two times
; are given in 24 hour format. For example, 12:05 and 13:03
; are separated by 58 minutes.
; (minutesBetween 12 5 13 3) --> 58
; (minutesBetween 13 3 12 5) --> 58
; (minutesBetween 0 0 23 59) --> 1
; (minutesBetween 23 59 0 0) --> 1
(define (minutesBetween h1 m1 h2 m2)
  (cond
    ( (and (= h1 0) (= h2 0) ) (abs(- m1 m2)) )
    ( (= h1 0) (- (* (abs(- 24 h2)) 60) (abs(- m1 m2)) ) )
    ( (= h2 0) (- (* (abs(- h1 24)) 60) (abs(- m1 m2)) ) )
    (else (- (* (abs(- h1 h2)) 60) (abs(- m1 m2)) ) )
    )
)

(define (negativesHelper lst neglst)
  (cond 
    ( (NULL? lst) neglst)
    ( ( < (car lst) 0 ) (negativesHelper (cdr lst) (append neglst (list(car lst)) ) ) )
    (else (negativesHelper (cdr lst) neglst) )
    )
  )

; Accepts a simple list of numbers and returns the list containing only
; the negative numbers, in the order in which they originally appeared.
; MUST BE WRITTEN USING TAIL RECURSION.
; (negatives '(1 2 3 -2 0 -3)) --> (-2 -3)
; (negatives '()) --> ()
(define (negatives lst)
  (negativesHelper lst '() )
	
)

(define (reverseHelper lst revlst)
  (cond
    ((NULL? lst) revlst)
    (else (reverseHelper (cdr lst) (cons (car lst) revlst)))
    )
  )

; Accepts a list of items and returns the list with the top-level items
; in reversed order.
; (reverse '(a b c d)) --> (d c b a)
; (reverse '()) --> ()
(define (reverse lst)
  (reverseHelper lst '() )
)	

; Returns true iff the parameters is a flat list of numbers.
; (isFlatListOfNumbers '(1 2 3)) --> #t
; (isFlatListOfNumbers '()) --> #t
; (isFlatListOfNumbers '(1 2 a 3)) --> #f
; (isFlatListOfNumbers '(1 (2) 3)) --> #f
(define (isFlatListOfNumbers lst)
  (cond
    ( (NOT(LIST? lst)) #f)
    ( (or (NULL? lst) (= (length lst) 1)) #t )
    ( (Integer? (car lst)) (isFlatListOfNumbers (cdr lst)) )
    (else #f)
    )
)

(define (findMax lst)
  (if (= (length lst) 1) (car lst) (max (car lst) (findMax (cdr lst))))
  )

(define (findMin lst)
  (if (= (length lst) 1) (car lst) (min (car lst) (findMin (cdr lst))))
  )

; Returns a list of two numeric values. The first is the smallest
; in the list and the second is the largest in the list. 
; lst -- a flat list of numbers, with length >= 1.
;(minAndMax '(1 2 3 -9 20 5)) -> (-9 20)
(define (minAndMax lst)
  (list (findMin lst) (findMax lst))
    
)

(define (crossProductHelper ele lst)
  (cond 
    ( (NULL? lst) '() )
    (else (cons (list ele (car lst)) (crossProductHelper ele (cdr lst)) ))								 
    )
  )


; The paramters are two lists. The result should contain the cross product
; between the two lists. That is, all elements of the first list are paired
; with all elements of the second lists. All of these pairs are put into a
; list of pairs.
; (crossProduct '(1 2) '(a b c)) --> ((1 a) (1 b) (1 c) (2 a) (2 b) (2 c))
; lst1 & lst2 -- two flat lists.
(define (crossProduct lst1 lst2)
  (cond
   ( (NULL? lst1) '() ) 
   ( (append (crossProductHelper (car lst1) lst2) (crossProduct (cdr lst1) lst2) ))
   )
  )

; Copies a list structure, but replaces a value (old) with a different value (new).
; (replace 'a 'X '(a b c d a b c)) --> (x b c d x b c)
; (replace 'a 'X '(a b (c d a) b c)) --> (x b (c d x) b c)
(define (replace old new lst)
	'()
)

; Returns a list containing the latitude and longitude of particular location.
; The location is specified by zipcode, city, state, and county.
; If there is more than one match, give the first match. Return
; the empty list if the location does not exist.
(define (getLatLon zipCode cityName state county places)
  (cond
    ( (NULL? places) '() )
    ( (and (=(car (car places)) zipCode) (EQUAL?(cadr (car places)) cityName) (EQUAL? (cadr(cdr(car places))) state) (EQUAL? (cadr(cdr(cdr(car places)))) county) ) 
     (list (cadr(cdr(cdr(cdr(car places))))) (cadr(cdr(cdr(cdr(cdr(car places)))))) ) )
    (else (getLatLon zipCode cityName state county (cdr places)) ) 
    )

)




(define (getStatesThatContainCityHelper city places statelst) 
    (cond 
      ( (NULL? places) statelst)
      ( (and (EQUAL? (cadr(car places)) city) (NOT(LIST? (member (cadr(cdr(car places))) statelst))))
       (getStatesThatContainCityHelper city (cdr places) (cons (cadr(cdr(car places))) statelst)) )
      (else (getStatesThatContainCityHelper city (cdr places) statelst))
      ) 
  )

; Returns a list of states that contain this city name. The states should
; appear at most once and be sorted.
; city -- the name of the city 
; places -- the zipcode DB
(define (getStatesThatContainThisCity city places)
  (getStatesThatContainCityHelper city places '() )
)

; Returns the distance (in miles) between two specific locations in the US.
; Use lat/lon. Look up the Haversine formulat.
; zipCode1, cityName1.... information about first location
; zipCode2, cityName2.... information about second location
; return 0 if either location does not exist
(define (getDistanceBetweenZipCodes zipCode1 cityName1 state1 county1
									zipCode2 cityName2 state2 county2)
	0
)

; Returns a list of items that satisfy a predicates.
; lst -- list of items
; theFilter -- predicates to apply to the individual elements
; (simpleFilter '(1 2 3 4 100) EVEN?) --> (2 4 100)
(define (simpleFilter lst theFilter)
  (cond 
    ( (NULL? lst) '() )
    ( (theFilter (car lst)) (cons (car lst) (simpleFilter (cdr lst) theFilter)) )
    (else (simpleFilter (cdr lst) theFilter))
    )
)

; Returns a list of items that satisfy all given predicates.
; lst -- flat list of items
; theFilters -- list of predicates to apply to the individual elements
; (filterList '(1 2 3 4 -4 -3 -2 -1 0) '(EVEN?)) --> (2 4 -4 -2 0)
; (filterList '(1 2 3 4 100) '(EVEN? POSITIVE?)) --> (2 4)
(define (complexFilter lst theFilters)
	lst
)
