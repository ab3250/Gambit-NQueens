(define (make-board n)
    (let loop ((cnt 0)(brd '()))
    (if (not (= cnt n))                                
            (loop (+ cnt 1)(cons (make-list n 0) brd ))
            brd)))

(define (make-lines n)
    (let looprow ((rowcnt 0)(lin '()))
        (if (not (= rowcnt n))
            (let loopcol ((colcnt 0)(smrow '()))
                (if (not (= colcnt n))
                    (loopcol (+ colcnt 1) (cons (if (= colcnt rowcnt) 1 0 ) smrow ))
                    (looprow (+ rowcnt 1)(cons smrow lin))))
            lin)))

(define (get-list-index l el)
    (if (null? l)
        -1
        (if (= (car l) el)
            0
            (let ((result (get-list-index (cdr l) el)))
                (if (= result -1)
                    -1
                    (+ result 1))))))

 (define (row_col->cell row col) 
    (+ (* row n) col))

(define (setval! row col val board)	
	(list-set! board (row_col->cell row col) val))

(define (getval row col board)
	(list-ref board (row_col->cell row col)))


(define (permutations x)
  (let ((x x)
        (perms (list x)))
    (define (P n)
      (if (> n 1)
          (do ((j (- n 1) (- j 1)))
              ((zero? j)
               (P (- n 1)))
              (P (- n 1))
              (F n))))
    (define (F n)
      (set! x (revloop x n (list-tail x n)))
      (set! perms (cons x perms)))
    (define (revloop x n y)
      (if (zero? n)
          y
          (revloop (cdr x)
                   (- n 1)
                   (cons (car x) y))))
    (define (list-tail x n)
      (if (zero? n)
          x
          (list-tail (cdr x) (- n 1))))
    (P (length x))
    perms))

(define (flatten x)
  (cond ((null? x) '())
        ((pair? x) (append (flatten (car x)) (flatten (cdr x))))
        (else (list x))))


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

	(if (and
    (checkul row col board)  
    (checkdl row col board) 
    (checkur row col board) 
    (checkdr row col board)
    (checkcol row col board) 
    (checkrow row col board)
  )#t #f))