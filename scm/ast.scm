(define (tagged-list? l t)
  (and (pair? l)
	   (eq? (car l)
			t)))

(define (literal? l)
  (or (number? l)
	  (boolean? l)
	  (string? l)
	  (symbol? l)))

(define (reference? r)
  (symbol? r))

(define (application? a)
  (pair? a))
(define (application-function a)
  (car a))
(define (application-arguments a)
  (cdr a))
(define (make-application applicand . arguments)
  (cons applicand arguments))

(define (set? s)
  (tagged-list? s 'set!))
(define (set-variable s)
  (cadr s))
(define (set-value-expression s)
  (caddr s))
(define (make-set variable value-expression)
  (list 'set! variable value-expression))

(define (if? i)
  (tagged-list? i 'if))
(define (if-predicate i)
  (cadr i))
(define (if-true-case i)
  (caddr i))
(define (if-false-case i)
  (cadddr i))
(define (make-if predicate true-case false-case)
  (list 'if predicate true-case false-case))

(define (begin? b)
  (tagged-list? b 'begin))
(define (begin-body b)
  (cdr b))
(define (make-begin body)
  (cons 'begin body))

(define (lambda? l)
  (tagged-list? l 'lambda))
(define (lambda-parameters l)
  (cadr l))
(define (lambda-body l)
  (cddr l))
(define (make-lambda parameters body)
  (list 'lambda parameters body))
