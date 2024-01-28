(in-package :cl-user)

(uiop:define-package :cl-sdl2-hershey/example
  (:use :cl :cl-sdl2-hershey)
  (:export #:main))

(in-package :cl-sdl2-hershey/example)


(defun clear-background (renderer)
  (sdl2:set-render-draw-color renderer 255 255 255 255)
  (sdl2:render-clear renderer))


(defun main ()
  (hershey-init)
  (sdl2:with-init (:everything)
    (sdl2:with-window (window :title "cl-sdl2-hershey" :w 800 :h 900 :flags '(:shown))
      (sdl2:with-renderer (renderer window :flags '(:accelerated))
        (sdl2:with-event-loop (:method :poll)
          (:keyup (:keysym keysym)
                  (when (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-escape)
                    (sdl2:push-event :quit)))
          (:idle ()
                 (clear-background renderer)
                 (sdl2:set-render-draw-color renderer 0 0 0 255)
                 (with-font *roman-complex-small-font* 1.0
                   (render-hershey-string renderer 100 40 "ROMAN Complex Small Font")
                   (render-hershey-string renderer 100 80 "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                   (render-hershey-string renderer 100 120 "abcdefghijklmnopqrstuvwxyz")
                   (render-hershey-string renderer 100 160 "0123456789"))
                 (with-font *roman-complex-font* 1.0
                   (render-hershey-string renderer 100 200 "Roman Complex Font")
                   (render-hershey-string renderer 100 240 "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                   (render-hershey-string renderer 100 280 "abcdefghijklmnopqrstuvwxyz")
                   (render-hershey-string renderer 100 320 "0123456789"))
                 (with-font *roman-simplex-font* 1.0
                   (render-hershey-string renderer 100 360 "Roman Simplex Font")
                   (render-hershey-string renderer 100 400 "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                   (render-hershey-string renderer 100 440 "abcdefghijklmnopqrstuvwxyz")
                   (render-hershey-string renderer 100 480 "0123456789"))
                 (with-font *script-simplex-font* 1.0
                   (render-hershey-string renderer 100 520 "Script Simplex Font")
                   (render-hershey-string renderer 100 560 "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                   (render-hershey-string renderer 100 600 "abcdefghijklmnopqrstuvwxyz")
                   (render-hershey-string renderer 100 640 "0123456789"))
                 (with-font *script-complex-font* 1.0
                   (render-hershey-string renderer 100 680 "Script Complex Font")
                   (render-hershey-string renderer 100 720 "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                   (render-hershey-string renderer 100 760 "abcdefghijklmnopqrstuvwxyz")
                   (render-hershey-string renderer 100 800 "0123456789"))



                 (sdl2:render-present renderer)
                 (sdl2:delay 80))
          (:quit () t))))))
