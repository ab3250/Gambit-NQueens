#!r7rs
(import(scheme base)(scheme write))

(define n 8)

(define (make-board n)
    (let loop ((cnt 0)(brd '()))
    (if (not (= cnt n))                                
            (loop (+ cnt 1)(cons (make-list n 0) brd ))
            brd)))

(display (make-board 8))