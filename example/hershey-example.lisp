(in-package :cl-user)

(uiop:define-package :cl-sdl2-hershey/example
  (:use :cl :cl-sdl2-hershey)
  (:export #:main))

(in-package :cl-sdl2-hershey/example)


(defun clear-background (renderer)
  (sdl2:set-render-draw-color renderer 255 255 255 255)
  (sdl2:render-clear renderer))


(defun render-font (y name font renderer)
  (with-font (font 1.0)
    (render-hershey-string renderer 100 y name)
    (render-hershey-string renderer 100 (+ y 40) "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    (render-hershey-string renderer 100 (+ y 80) "abcdefghijklmnopqrstuvwxyz")
    (render-hershey-string renderer 100 (+ y 120) "0123456789")))


(defun main ()
  (hershey-init)
  (sdl2:with-init (:everything)
    (sdl2:with-window (window :title "cl-sdl2-hershey" :w 800 :h 1940 :flags '(:shown))
      (sdl2:with-renderer (renderer window :flags '(:accelerated))
        (sdl2:with-event-loop (:method :poll)
          (:keyup (:keysym keysym)
                  (when (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-escape)
                    (sdl2:push-event :quit)))
          (:idle ()
                 (clear-background renderer)
                 (sdl2:set-render-draw-color renderer 0 0 0 255)
                 (render-font 40 "Roman Complex Small Font" *roman-complex-small-font* renderer)
                 (render-font 200 "Roman Complex Font" *roman-complex-font* renderer)
                 (render-font 360 "Roman Simplex Font" *roman-simplex-font* renderer)
                 (render-font 520 "Script Simplex Font" *script-simplex-font* renderer)
                 (render-font 680 "Script Complex Font" *script-complex-font* renderer)
                 (render-font 840 "Gothic English Triplex Font" *gothic-english-triplex-font* renderer)
                 (render-font 1000 "Gothic German Triplex Font" *gothic-german-triplex-font* renderer)
                 (render-font 1160 "Gothic Italian Triplex Font" *gothic-italian-triplex-font* renderer)
                 (render-font 1320 "Greek Complex Font" *greek-complex-font* renderer)
                 (render-font 1480 "Greek Complex Small Font" *greek-complex-small-font* renderer)
                 (render-font 1640 "Greek Plain Font" *greek-plain-font* renderer)
                 (render-font 1800 "Greek Simplex Font" *greek-simplex-font* renderer)
                 (sdl2:render-present renderer)
                 (sdl2:delay 80))
          (:quit () t))))))
