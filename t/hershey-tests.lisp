(uiop:define-package cl-sdl2-hershey/tests
  (:use :cl :parachute)
  (:import-from :cl-sdl2-hershey))

(in-package :cl-sdl2-hershey/tests)

(define-test test-1 ()
  (true (= 1 0)))

(define-test test-2 ()
  (true (= 1 1)))

;; (run-suite *package*)
