(defpackage #:secret-values
  (:use #:common-lisp)
  (:export
   #:secret-value
   #:secret-value-p
   #:conceal-value
   #:reveal-value
   #:ensure-value-revealed))
