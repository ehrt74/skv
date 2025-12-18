(uiop:define-package skv
  (:use :cl :jsown)
  (:export :main))
(in-package #:skv)

(defun print-help ()
  (format t #."skv
help                       print this help
get <scheme> <key>         gets key from scheme
put <scheme> <key> <value> puts key value in scheme
rm <scheme> <key>          removes key from scheme
ls <scheme>                lists all keys in scheme
scheme-ls                  lists all schemes
scheme-rm scheme           deletes scheme
"))

(defparameter *base-dir* (merge-pathnames ".cache/skv/" (user-homedir-pathname)))

(ensure-directories-exist *base-dir*)

(defun list-schemes ()
  (let ((files (uiop:directory-files *base-dir*)))
    (dolist (file files)
      (when (string-equal (pathname-type file) "json")
	  (format t "~a~%" (pathname-name file))))))

(defun get-db-name (scheme)
  (merge-pathnames (format nil "~a.json" scheme) *base-dir*))

(defun get-db (scheme)
  (let ((db-path (get-db-name scheme)))
    (jsown:parse
     (if (uiop:file-exists-p db-path)
	 (uiop:read-file-string db-path)
	 "{}"))))

(defun save-db (scheme db)
  (let ((db-path (get-db-name scheme)))
    (with-open-file (f db-path :direction :output
			       :if-does-not-exist :create
			       :if-exists :supersede)
      (write-sequence (jsown:to-json db) f))))

(defun get-val (scheme key)
  (let ((db (get-db scheme)))
    (multiple-value-bind (val exists-p) (jsown:val-safe db key)
      (if exists-p
	(format t val)
	(format *error-output* "not found")))))

(defun set-val (scheme key val)
  (let* ((db (get-db scheme))
	 (db-new (jsown:extend-js db (key val))))
    (save-db scheme db-new)))

(defun rm-key (scheme key)
  (let ((db (get-db scheme)))
    (save-db scheme (jsown:remkey db key))))

(defun list-all (scheme)
  (jsown:do-json-keys (k v) (get-db scheme)
    (format t "~a -> ~a~%" k v)))

(defun delete-scheme (scheme)
  (uiop:delete-file-if-exists (get-db-name scheme)))

(defun perform (args)
  (trivia:match args
    ((list "help") (print-help))
    ((list "get" <scheme> <key>) (get-val <scheme> <key>))
    ((list "put" scheme key val) (set-val scheme key val))
    ((list "rm" scheme key) (rm-key scheme key))
    ((list "ls" scheme) (list-all scheme))
    ((list "scheme-rm" scheme) (delete-scheme scheme))
    ((list "scheme-ls") (list-schemes))
    (_ (print-help))))

(defun main ()
  (perform (uiop:command-line-arguments)))
