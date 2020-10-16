(defsystem #:secret-values
  :name "secret-values"
  :licence "MIT"
  :description "Secret values is a Common Lisp library designed to
reduce the risk of accidentally revealing secret values such as
passwords."
  :author "Thomas Bakketun <thomas@bakketun.pro>"
  :depends-on ()
  :serial t
  :components ((:file "package")
               (:file "secret-values")))
