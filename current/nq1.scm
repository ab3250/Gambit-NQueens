#!r7rs

(c-declare 
#<<c-declare-end
#include "ws.h"
void ws_start(int);
c-declare-end
)
;;;;
(import
  (scheme base)
  (scheme write)
  (gambit))

(include "nqLib.scm")

(define rowvalues
   '((7 6 5 4 3 2 1 0)
     (0 7 6 5 4 3 2 1)
     (1 0 7 6 5 4 3 2)
     (2 1 0 7 6 5 4 3)
     (3 2 1 0 7 6 5 4)
     (4 3 2 1 0 7 6 5)  
     (5 4 3 2 1 0 7 6)
     (6 5 4 3 2 1 0 7)))

(define (read_one_row count)    
    (let loop1 ((cnttmp 0)(tmprowval rowvalues)) 
      (if (= cnttmp count)
        (car tmprowval)          
          (loop1 (+ cnttmp 1)(cdr tmprowval)))))

(define (board->JSONString key board)
    (let ((deck (map number->string (vector->list board))))
    (let loop1 ((idx 0)(end (length deck))(str (string-append "{\"" key "\":[")))     
      (if (not(= idx end))
          (loop1 
              (+ idx 1) 
              end 
              (string-append str "\"" (list-ref deck idx) "\"" (if(= idx (- end 1)) "]}" "," )))
              str))))

(define (solve_ut rowlist board)     
      (if (equal? rowlist '())
        #t
        (begin
          (let loopcol ((col 0))
            (if (< col n)
              (begin
                (if (possible? (car rowlist) col board)
                  (begin                           
                    (setval! (car rowlist) col 1 board)                           
                    (if (solve_ut (cdr rowlist) board)
                      (begin 
                        (ws_sendframe_txt gblFd  (board->JSONString "board" board) #f)                                               
                        #t)
                        (begin (setval! (car rowlist) col 0 board)))))
							  (loopcol (+ col 1)))))#f)))

 

(define  ws_sendframe_txt (c-lambda (int char-string bool) int "ws_sendframe_txt"))

(define ws_start (c-lambda (int) void "ws_start" ))

(c-define (onmessage fd msg size type) (int char-string unsigned-int64 int) void  "onmessage" "extern"
  (solve_ut (read_one_row (string->number msg))  (new-board))
)

(c-define (onopen fd) (int) void "onopen" "extern"
           (set! gblFd fd)
           (displayln (list 'opened fd )))

(c-define (onclose fd) (int) void "onclose" "extern"
            (set! gblFd 1)    
            (displayln (list 'closed fd)))

(define gblFd 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(solve)
(ws_start 0)



