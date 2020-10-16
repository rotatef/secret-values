(in-package :secret-values)


(defstruct secret-value
  (name)
  (symbol))


(defmethod print-object ((object secret-value) stream)
  (if (secret-value-name object)
      (print-unreadable-object (object stream :type t :identity t)
        (princ (secret-value-name object) stream))
      (print-unreadable-object (object stream :type t :identity t))))


(defun conceal-value (value &key name)
  "Conceals value into a SECRET-VALUE object. An optional name can be
provided to aid debugging."
  (let ((symbol (gensym (if (stringp name)
                            name
                            ""))))
    (setf (get symbol 'secret) (lambda () value))
    (make-secret-value :name name :symbol symbol)))


(defun reveal-value (secret-value)
  "Returns the value in SECRET-VALUE. An error of type TYPE-ERROR is
 signalled if the argument is not of type SECRET-VALUES."
  (funcall (get (secret-value-symbol secret-value) 'secret)))


(defun ensure-value-concealed (object &key name)
  "If object is already a of type SECRET-VALUE returns is unaltered,
  otherwise conceals it as if by calling CONCEAL-VALUE."
  (typecase object
    (secret-value object)
    (t (conceal-value object :name name))))


(defun ensure-value-revealed (object)
  "If object is type SECRET-VALUE returns the concealed value, otherwise returns object."
  (typecase object
    (secret-value (reveal-value object))
    (t object)))
