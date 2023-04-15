#!r7rs
(import(scheme base)(scheme write))

(include "nqlib.scm")

(define n 4)


(define (create-and-filter permlist board)  
  (let loop1 ((tmplst permlist))
    (if (equal? tmplst '())
      #t
      (begin
       ; (display (car tmplst) )  (newline)       
        (solve (car tmplst) (flatten (make-board n)))
        (loop1 (cdr tmplst))))))


(define (solve rowlist board) 
;(display board)  
  (let looprow ((rowtmp 0)(rowlsttmp rowlist))  
    (if (= rowtmp n)
        (begin (display board) (newline))
        (begin         
            (if (possible? rowtmp  (get-list-index (car rowlsttmp) 1)  board)
                  (begin                 
                   (setval! rowtmp (get-list-index (car rowlsttmp) 1)  1 board)
                   (looprow (+ rowtmp 1) (cdr rowlsttmp)))
                   #f)))))

;(display (make-lines n))

;(display (make-board n))

;(display (permutations (make-lines n)))

(create-and-filter (permutations (make-lines n))(make-board n))









