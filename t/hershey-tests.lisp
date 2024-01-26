(uiop:define-package cl-sdl2-hershey/tests
  (:use :cl :rove)
  (:import-from :cl-sdl2-hershey))

(in-package :cl-sdl2-hershey/tests)

(deftest test-1 ()
  (ok (= 1 1)))

(run-suite *package*)
