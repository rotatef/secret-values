(defpackage #:secret-values-tests
  (:use #:common-lisp #:secret-values))

(in-package #:secret-values-tests)

(defparameter *password* (conceal-value "secret password"))

(defun test ()
  (reveal-value *password*))
