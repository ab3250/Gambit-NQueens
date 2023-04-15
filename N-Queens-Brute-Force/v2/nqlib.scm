(define (make-board n)
    (let loop ((cnt 0)(brd '()))
    (if (not (= cnt n))                                
            (loop (+ cnt 1)(cons (make-list n 0) brd ))
            brd)))

(define (make-lines n)
    (let loopcol ((colcnt 0)(lin '()))
        (if (not (= colcnt n))
            (let looprow ((rowcnt 0)(smcol '()))
                (if (not (= rowcnt n))
                    (looprow (+ rowcnt 1) (cons (if (= rowcnt colcnt) 1 0 ) smcol ))
                    (loopcol (+ colcnt 1)(cons smcol lin))))
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

 (define (col_row->cell col row) 
    (+ (* col n) row))

(define (setval! col row val board)	
	(list-set! board (col_row->cell col row) val))

(define (getval col row board)
	(list-ref board (col_row->cell col row)))


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


(define (possible? col row board)
  
  (define (checkul col row board)
      (let loopul ((coltmp col)(rowtmp row))
        (if (not (or (< coltmp 0) (< rowtmp 0)))
          (begin        
            (if (= (getval coltmp rowtmp board) 0)
              (loopul (- coltmp 1) (- rowtmp 1))
              #f))
              #t)))


  (define (checkur col row board)
      (let loopur ((coltmp col)(rowtmp row))
        (if (not (or (< coltmp 0)(= rowtmp n)))
          (begin
            (if (= (getval coltmp rowtmp board) 0)           
              (loopur (- coltmp 1) (+ rowtmp 1))
              #f))
              #t)))


  (define (checkdl  col row board)
    (let loopdl ((coltmp col)(rowtmp row))
      (if (not (or (= coltmp n)(< rowtmp 0)))
        (begin
          (if (= (getval coltmp rowtmp board) 0)
            (loopdl (+ coltmp 1) (- rowtmp 1))
            #f))
            #t)))
    
  (define (checkdr col row board)
		(let loopdr ((coltmp col)(rowtmp row))
			(if (not (or (= coltmp n)(= rowtmp n)))
				(begin
					(if (= (getval coltmp rowtmp board) 0)
            (loopdr (+ coltmp 1) (+ rowtmp 1))
						#f))
						#t)))

	(define (checkrow col row board)
		(let loopcol ((coltmp 0))
			(if (< coltmp n)
				(begin						
					(if (= (getval coltmp row board) 0)
						(loopcol (+ coltmp 1))
						#f))
						#t)))
			
	(define (checkcol col row board)
		(let looprow ((rowtmp 0))
			(if (< rowtmp n)
				(begin
					(if (= (getval col rowtmp board) 0)
						(looprow (+ rowtmp 1))
						#f))
						#t)))	

	(if (and
    (checkul col row board)  
    (checkdl col row board) 
    (checkur col row board) 
    (checkdr col row board)
    (checkrow col row board) 
    (checkcol col row board)
  )#t #f))