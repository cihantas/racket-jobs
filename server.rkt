#lang racket 

(require web-server/servlet
         web-server/servlet-env
         web-server/dispatch
         db)

(sqlite3-connect #:database 'memory)

(struct job (title external_url is_remote))
(struct company (location))

(define (app request)
  (app-dispatch request))

; Route requests to mapped controller functions.
(define-values (app-dispatch app-url)
  (dispatch-rules
    [("") list-jobs]))

(define (list-jobs req)
  (response/xexpr
   '(html
     (head (title "Racket Jobs")
           (body (h1 "Racket Jobs"))))))

(serve/servlet app
               #:port 8080
               #:servlet-path "/"
               #:servlet-regexp #rx""
               #:command-line? #t)