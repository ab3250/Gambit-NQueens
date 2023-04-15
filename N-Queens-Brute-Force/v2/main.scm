#!r7rs
(import(scheme base)(scheme write))

(include "nqlib.scm")

(define n 8)


(define (create-and-filter permlist board)  
  (let loop1 ((tmplst permlist))
    (if (equal? tmplst '())
      #t
      (begin
       ; (display (car tmplst) )  (newline)       
        (solve (car tmplst) (flatten (make-board n)))
        (loop1 (cdr tmplst))))))


(define (solve collist board) 
;(display board)  
  (let loopcol ((coltmp 0)(collsttmp collist))  
    (if (= coltmp n)
        (begin (display board) (newline))
        (begin         
            (if (possible? coltmp  (get-list-index (car collsttmp) 1)  board)
                  (begin                 
                   (setval! coltmp (get-list-index (car collsttmp) 1)  1 board)
                   (loopcol (+ coltmp 1) (cdr collsttmp)))
                   #f)))))

;(display (make-lines n))

;(display (make-board n))

;(display (permutations (make-lines n)))

(create-and-filter (permutations (make-lines n))(make-board n))









