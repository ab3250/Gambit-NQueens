#!r7rs
(import
  (scheme base)
  (scheme write))

(define n 8)

(define (new-board)  (make-vector (* n n) 0))

(define board (new-board))


(define (print-board board)
  (newline)
  (let looprow ((row 0))
    (let loopcol ((col 0)) 							
      (display (getval row col board))
      (display " ")
      (if (= col (- n 1)) (newline))				
      (if (< col (- n 1)) (loopcol (+ col 1))))			
    (if (< row (- n 1))(looprow (+ row 1))))
  (newline))
 (display (list rowtmp coltmp))

(define (checkul row col board)
		(let loopul ((rowtmp row)(coltmp col))
			(if (not (or (< rowtmp 0) (< coltmp 0)))
				(begin        
					(if (= (getval rowtmp coltmp board) 0)
          	(loopul (- rowtmp 1) (- coltmp 1))
						#f))
						#t)))


(define (checkur row col board)
		(let loopur ((rowtmp row)(coltmp col))
			(if (not (or (< rowtmp 0)(= coltmp n)))
				(begin
					(if (= (getval rowtmp coltmp board) 0)           
						(loopur (- rowtmp 1) (+ coltmp 1))
						#f))
						#t)))


	(define (checkdl  row col board)
		(let loopdl ((rowtmp row)(coltmp col))
			(if (not (or (= rowtmp n)(< coltmp 0)))
				(begin
					(if (= (getval rowtmp coltmp board) 0)
           	(loopdl (+ rowtmp 1) (- coltmp 1))
						#f))
						#t)))
	
  (define (checkdr row col board)
		(let loopdr ((rowtmp row)(coltmp col))
			(if (not (or (= rowtmp n)(= coltmp n)))
				(begin
					(if (= (getval rowtmp coltmp board) 0)
            (begin
            (setval! rowtmp coltmp 1 board)
						(loopdr (+ rowtmp 1) (+ coltmp 1)))
						#f))
						#t)))

(define (getval row col board)
	(vector-ref board (row_col->cell row col)))

(define (setval! row col val board)	
	(vector-set! board (row_col->cell row col) val))


 (define (row_col->cell row col) 
    (+ (* row n) col))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(checkdr 1 1 board)
(print-board board)


 
 ;          

