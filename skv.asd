(defsystem "skv"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on (:jsown :uiop :trivia)
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :build-operation "program-op"
  :build-pathname "skv"
  :entry-point "skv:main"
  :in-order-to ((test-op (test-op "skv/tests"))))

(defsystem "skv/tests"
  :author ""
  :license ""
  :depends-on ("skv"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for skv"
  :perform (test-op (op c) (symbol-call :rove :run c)))
