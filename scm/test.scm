(require racket/pretty)
(require test-engine/racket-tests)

(define (%halt r)
  r)

(define (%set! k t v)
  (set! t v)
  (k v))

(define (%+ c v1 v2)
  (c (+ v1 v2)))

(define (%- c v1 v2)
  (c (- v1 v2)))

(define-syntax check-cps
  (syntax-rules ()
				((check-cps <ast> <exp> <val>)
				 (begin (check-expect (cps-convert <ast>) <exp>)
						(check-expect (eval (cps-convert <ast>)) <val>)))))

(define-syntax check-cc
  (syntax-rules ()
				((check-cc <ast> <exp> <val>)
				 (begin (check-expect (closure-convert <ast>) <exp>)
						(check-expect (eval (closure-convert <ast>)) <val>)))))
