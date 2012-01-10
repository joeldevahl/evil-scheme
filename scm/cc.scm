(define (make-closure-ref self-variable i)
  (list '%closure-ref self-variable (+ i 1)))

(define (free-var-position-helper v l n)
  (cond ((null? l)
		 #f)
		((eq? (car l) v)
		 n)
		(else
		  (free-var-position-helper v (cdr l) (+ n 1)))))
(define (free-var-position v l)
  (free-var-position-helper v l 0))

(define (cc ast self-variable free-variables)
  (cond ((literal? ast)
		 ast)
		((reference? ast)
		 (let ((i (free-var-position ast free-variables)))
		   (if i
			 (make-closure-ref self-variable i)
			 ast)))
		((set? ast)
		 (make-set (set-variable ast)
				   (cc (set-value-expression ast)
					   self-variable
					   free-variables)))
		((if? ast)
		 (make-if
		   (cc (if-predicate ast) self-variable free-variables)
		   (cc (if-true-case ast) self-variable free-variables)
		   (cc (if-false-case ast) self-variable free-variables)))
		((begin? ast)
		  (error "should never happen after cps conversion" ast))
		((lambda? ast)
		 '())
		((application? ast)
		 '())
		(else
		  (error "unknown ast node" ast))))

(define (closure-convert ast)
  (cc ast #f '()))
