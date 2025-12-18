(defpackage skv/tests/main
  (:use :cl
        :skv
        :rove))
(in-package :skv/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :skv)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
