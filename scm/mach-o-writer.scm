(define (write-mach-o-header)
  (word #xfeedface) ; mach-o header magic
  (word 7) ; CPU type (x86)
  (word 0) ; endian ness (little)
  (word 2) ; file type (executable)
  (word 0) ; num commands
  (word 0) ; size of commands
  (word 0)) ; flags

(define (write-mach-o-segment)
  (word 0x1) ; load segment
  (word 0) ; size
  (bytes #"__TEXT\0\0\0\0\0\0\0\0\0\0") ; name, 16 bytes
