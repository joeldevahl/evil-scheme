(require racket/port)
(require rnrs/arithmetic/bitwise-6)

(define (byte b)
  (write-byte b))
(define (op b)
  (byte b))
(define (op2 b)
  (byte #x0F)
  (byte b))
(define (dword dw)
  (byte (quotient (bitwise-and dw #xFF000000) #x1000000))
  (byte (quotient (bitwise-and dw #xFF0000) #x10000))
  (byte (quotient (bitwise-and dw #xFF00) #x100))
  (byte (bitwise-and dw #xFF)))

(define (merge . v)
  (let loop ((c 0) (l v))
	(if (null? l)
	  (dword c)
	  (loop (bitwise-ior c (car l)) (cdr l)))))

(define shift bitwise-arithmetic-shift)

(define (op c)
  (shift c 26))

(define (addi dst src val)
  (merge (op #xE)
		 (shift dst 21)
		 (shift src 16)
		 (shift val 0)))

(define (li dst val)
  (addi dst 0 val))

(define (bclr bo bi)
  (merge (op #x13)
		 (shift bo 21)
		 (shift bi 16)
		 (shift #x0 11)
		 (shift #x10 1)
		 (shift #x0 0)))

(define (blr)
  (bclr 20 0))

(with-output-to-file "test.image" (lambda ()
  (li 3 42)
  (blr)))
