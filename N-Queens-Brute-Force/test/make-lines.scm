#!r7rs
(import(scheme base)(scheme write))

(define n 8)

(define (make-board n)
    (let looprow ((rowcnt 0)(brd '()))
        (if (not (= rowcnt n))
            (let loopcol ((colcnt 0)(smrow '()))
                (if (not (= colcnt n))
                    (loopcol (+ colcnt 1) (cons (if (= colcnt rowcnt) 1 0 ) smrow ))
                    (looprow (+ rowcnt 1)(cons smrow brd))))
            brd)))

(display (make-board 4))