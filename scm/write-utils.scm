(define (byte b)
  (write-byte b))
  ;(printf "~x\n" b))

(define (bytes b)
  (write-bytes b))

(define (word w)
  (byte (bitwise-and w #xFF))
  (byte (quotient (bitwise-and w #xFF00) #x100))
  (byte (quotient (bitwise-and w #xFF0000) #x10000))
  (byte (quotient (bitwise-and w #xFF000000) #x1000000)))
