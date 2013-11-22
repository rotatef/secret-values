(in-package :secret-values)


(defstruct secret-values
  (closure)
  (count))


(defmethod print-object ((object secret-values) stream)
  (print-unreadable-object (object stream :type t :identity t)
    (format stream "~A values" (secret-values-count object))))


(defun conceal-values (&rest values)
  "Conceals values into a SECRET-VALUES object."
  ;; wrapping the secret values in a closure reduces the chance of
  ;; accidently revealing the values.
  (make-secret-values :count (length values)
                      :closure (lambda () values)))


(defun reveal-values (secret-values)
  "Returns the values in SECRET-VALUES as multiple values.
An error of type TYPE-ERROR is signalled if the argument is not of type SECRET-VALUES."
  (values-list (funcall (secret-values-closure secret-values))))


(defun ensure-values-revealed (object)
  "If object is type SECRET-VALUES returns the values in SECRET-VALUES as multiple values, otherwise returns object."
  (typecase object
    (secret-values (reveal-values object))
    (t object)))
