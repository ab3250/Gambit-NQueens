#!r7rs
(import(scheme base)(scheme write))

(define rowvalues
   '((7 6 5 4 3 2 1 0)
     (0 7 6 5 4 3 2 1)
     (1 0 7 6 5 4 3 2)
     (2 1 0 7 6 5 4 3)
     (3 2 1 0 7 6 5 4)
     (4 3 2 1 0 7 6 5)  
     (5 4 3 2 1 0 7 6)
     (6 5 4 3 2 1 0 7)))

(define (read_one_row rowvalues count)    
    (let loop1 ((cnttmp 0)(tmprowval rowvalues)) 
      (if (= cnttmp count)
        (car tmprowval)          
          (loop1 (+ cnttmp 1)(cdr tmprowval)))))

(display (read_one_row rowvalues 7))