(define var-base 0)
(define (make-var v)
  (let ((n var-base))
	(set! var-base (+ var-base 1))
	(string->symbol (string-append (symbol->string v)
								   "."
								   (number->string n)))))

(define (cps-list-body ast-list inner x)
  (cps-list (cdr ast-list)
			(lambda (new-asts)
			  (inner (cons x new-asts)))))

(define (cps-list ast-list inner)
  (cond ((null? ast-list)
		 (inner '()))
		((or (literal? (car ast-list))
			 (reference? (car ast-list)))
		 (cps-list-body ast-list inner (car ast-list)))
		(else
		 (let ((r (make-var 'r)))
		   (cps (car ast-list)
				(make-lambda (list r) (cps-list-body ast-list
													 inner
													 r)))))))

(define (cps-sequence ast-list cont)
  (cond ((null? ast-list)
		 (list cont #f))
		((null? (cdr ast-list))
		 (cps (car ast-list) cont))
		(else
		  (cps (car ast-list)
			   (make-lambda 
					 (list (make-var 'r))
					 (cps-sequence (cdr ast-list) cont))))))

(define (cps ast cont)
  (cond ((literal? ast)
		 (list cont ast))
		((reference? ast)
		 (list cont ast))
		((set? ast)
		 (let ((r (make-var 'r)))
		   (cps (set-value-expression ast)
				(make-lambda
				  (list r)
				  (make-application cont
									(make-set
									  (set-variable ast)
									  r))))))
		((if? ast)
		 (let ((k (make-var 'k)))
		   (make-application
			 (make-lambda (list k)
						  (cps (if-predicate ast)
							   (let ((r (make-var 'r)))
								 (make-lambda
								   (list r)
								   (make-if
									 r
									 (cps (if-true-case ast) k)
									 (cps (if-false-case ast) k))))))
			 cont)))
		((begin? ast)
		 (cps-sequence (begin-body ast) cont))
		((lambda? ast)
		 (let ((k (make-var 'k)))
		   (make-application cont
							 (make-lambda (cons k (lambda-parameters ast))
										  (cps-sequence (lambda-body ast) k)))))
		((application? ast)
		 (cps-list ast (lambda (args)
						 (cons (car args)
							   (cons cont
									 (cdr args))))))
		(else
		  (error "unknown ast node" ast))))

(define (cps-convert ast)
  (let ((r (make-var 'r)))
	(cps ast (make-lambda (list r) (list '%halt r)))))
