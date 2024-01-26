(asdf:defsystem cl-sdl2-hershey
  :depends-on (:sdl2 :assoc-utils)
  :serial t
  :components ((:module "src"
                :components((:file "package")
                            (:file "fonts")
                            (:file "hershey")
                            (:static-file "hershey-glyphs.txt"))
                :in-order-to ((test-op (test-op :cl-sdl2-hershey/tests))))))

(asdf:defsystem cl-sdl2-hershey/tests
  :depends-on (:cl-sdl2-hershey :rove)
  :serial t
  :components ((:module "t"
                :components ((:file "hershey-tests"))))
  :perform (test-op (op c) (symbol-call :rove :run c)))

(asdf:defsystem cl-sdl2-hershey/example
  :depends-on (:cl-sdl2-hershey :sdl2)
  :serial t
  :components ((:module "example"
                :components ((:file "hershey-example")))))
