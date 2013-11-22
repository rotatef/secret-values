(in-package :secret-values)


(defstruct secret-value
  (name)
  (symbol))


(defmethod print-object ((object secret-value) stream)
  (print-unreadable-object (object stream :type t :identity t)
    (princ (secret-value-name object) stream)))


(defun conceal-value (value &key (name ""))
  "Conceals value into a SECRET-VALUE object. An optional name can be
provided to aid debugging."
  (check-type name string)
  (let ((symbol (gensym name)))
    (setf (get symbol 'secret) (lambda () value))
    (make-secret-value :name name :symbol symbol)))


(defun reveal-value (secret-value)
  "Returns the value in SECRET-VALUE. An error of type TYPE-ERROR is
 signalled if the argument is not of type SECRET-VALUES."
  (funcall (get (secret-value-symbol secret-value) 'secret)))


(defun ensure-value-revealed (object)
  "If object is type SECRET-VALUE returns the concealed value, otherwise returns object."
  (typecase object
    (secret-value (reveal-value object))
    (t object)))
