;(define-library (nqLib)
; (export possible? row_col->cell getval setval! let/ec done print-board)
; (begin

(define (displayln x)
  (display x)
  (newline))


(define n 8)

(define (solve)
 (let loop2 ((count 0))
    (if (< count n)
      (let ((rowlist (list-ref rowvalues count)))        
        (solve_ut rowlist (new-board))
        (loop2 (+ count 1))))))

(define (new-board)  (make-vector (* n n) 0))

(define (possible? row col board)

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
          (loopdr (+ rowtmp 1) (+ coltmp 1))
          #f))
      #t)))

(define (checkcol row col board)
  (let looprow ((rowtmp 0))
    (if (< rowtmp n)
      (begin						
        (if (= (getval rowtmp col board) 0)
          (looprow (+ rowtmp 1))
          #f))
      #t)))
			
(define (checkrow row col board)
  (let loopcol ((coltmp 0))
    (if (< coltmp n)
      (begin
        (if (= (getval row coltmp board) 0)
          (loopcol (+ coltmp 1))
          #f))
      #t)))

	(if (and then
    (checkul row col board)  
    (checkdl row col board) 
    (checkur row col board) 
    (checkdr row col board)
    (checkcol row col board) 
    (checkrow row col board))#t #f))
 
(define (row_col->cell row col) 
  (+ (* row n) col))

(define (setval! row col val board)	
	(vector-set! board (row_col->cell row col) val))

(define (getval row col board)
	(vector-ref board (row_col->cell row col)))

(define-syntax let/ec 
  (syntax-rules ()
    ((_ return body ...)
     (call-with-current-continuation
      (lambda (return)
        body ...)))))

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


(define (done board)  
  (let looprow ((row 0)(count 0))
    (if (< row n)
        (begin
          (let loopcol ((col 0))
            (if (< col n)             
                (begin
                  (if (= 1 (getval row col board))                                             
                        (set! count (+ 1 count))
                        (loopcol (+ col 1))))))
		(looprow (+ row 1) count))
        (if (= count n) (print-board board)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

