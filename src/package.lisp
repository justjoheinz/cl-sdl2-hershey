(in-package :cl-user)

(uiop:define-package :cl-sdl2-hershey
  (:use :cl :assoc-utils)
  (:export
   #:hershey-character
   #:make-hershey-character
   #:hershey-character-p
   #:copy-hershey-character
   #:hershey-character-letter-number
   #:hershey-character-left-pos
   #:hershey-character-right-pos
   #:hershey-character-instructions
   #:render-hershey-string
   #:hershey-init
   #:*roman-simplex-font*
   #:*roman-plain-font*
   #:*roman-triplex-font*
   #:*roman-duplex-font*
   #:*roman-complex-font*
   #:*roman-complex-small-font*
   #:with-font
   #:*script-simplex-font*
   #:*script-complex-font*
   #:*gothic-english-triplex-font*
   #:*gothic-german-triplex-font*
   #:*gothic-italian-triplex-font*))
