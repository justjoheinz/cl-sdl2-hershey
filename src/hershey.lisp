(in-package :cl-sdl2-hershey)


(defvar *offset-x* 0)
(defvar *offset-y* 0)
(defvar *scale* 1.0)
(defvar *hershey-characters* nil)
(defvar *default-font* *roman-simplex-font*)

(defconstant +R+ (char-code #\R)
  "the ASCII value of the char #\R.
Hershey glyph coordinates are specified relative to this value.")


(defmacro with-font (font scale &body body)
  `(let ((*default-font* ,font)
         (*scale* ,scale))
     ,@body))

(defstruct hershey-character
  "a struct which represents a single character in the hershey font."
  (letter-number 0)
  (left-pos 0)
  (right-pos 0)
  (instructions nil))

(defun hershey-character-width (hershey-character)
  "determine the width of a hershey character"
  (declare (type hershey-character hershey-character))
  (- (hershey-character-right-pos hershey-character)
     (hershey-character-left-pos hershey-character)))

(defun hershey-character-parse-string (string)
  "parse a string which defines a glyph/character and convert it into
a hershey-character structure."
  (let* ((letter-number (parse-integer string :start 0 :end 5))
         (number-of-vertices (parse-integer string :start 5 :end 8))
         (left-pos (transform-letter (subseq string  8  9)))
         (right-pos (transform-letter (subseq string 9  10)))
         (coordinates (subseq string 10))
         (instructions
           (loop for i from 0 below (1- number-of-vertices)
                 collect (let* ((pos (* i 2))
                                (x-char  (subseq coordinates pos (1+ pos)))
                                (y-char (subseq coordinates (1+ pos) (+ pos 2))))
                           (if (pen-up-p (list x-char y-char))
                               (list :pen-up)
                               (list :pen-down
                                     (transform-letter x-char)
                                     (transform-letter y-char)))))))
    (make-hershey-character :letter-number letter-number
                            :left-pos left-pos :right-pos right-pos
                            :instructions (list-to-pairs instructions))))


;; input a list, e.g. (1 2 3 4 5)
;; return a list of pairs, e.g. ((1 2) (2 3) (3 4) (4 5))
(defun list-to-pairs (list)
  (declare (type list list))
  (loop for i from 0 below (- (length list) 1)
        collect (list (nth i list) (nth (1+ i) list))))

(defun hershey-init ()
  (let ((file-name (asdf:system-relative-pathname :cl-sdl2-hershey "src/hershey-glyphs.txt")))
    (setq *hershey-characters*
          (loop for s in (uiop:read-file-lines file-name)
                collect (let ((c (hershey-character-parse-string s)))
                          (cons (hershey-character-letter-number c)  c))))))


(defun transform-letter (char-or-string)
  "get the ASCII code from a character or single character string."
  (declare (type (or character string) char-or-string))
  (- (char-code (coerce char-or-string 'character)) +R+))


(defun pen-up-p (char-list)
  "check if the list elements represent a pen-up operation.
This is used during parsing of the hershey glyph string as well during drawing operations."
  (declare (type list char-list))
  (if (or (equalp char-list '(" " "R")) (equalp char-list '(:pen-up)))
      t
      nil))

(defun render-hershey-character (renderer char)
  "Draw a single character using the given renderer."
  (declare (type hershey-character char))

  (incf *offset-x* (- (* *scale* (hershey-character-left-pos char))))
  (loop for p in (hershey-character-instructions char)
        do (let ((fst (first p))
                 (snd (second p)))
             (if (or (pen-up-p fst) (pen-up-p snd))
                 nil
                 (trans renderer (second fst) (third fst) (second snd) (third snd)))))
  (incf *offset-x* (* (hershey-character-right-pos char) *scale*)))

(defun get-hershey-character (c)
  "get the hershey character for a given letter c in the default font.

The default font is specified by the special variable *DEFAULT-FONT*.
It can be overriden using WITH-FONT."
  (declare (type character c))
  (let* ((num (- (char-code c) 32))
         (idx (nth num *default-font*)))
    (aget *hershey-characters* idx)))


(defun render-hershey-string (renderer x1 y1 string)
  (declare (type string string))
  (let ((*offset-x* x1)
        (*offset-y* y1))
    (loop for c across string
          do (let ((char (get-hershey-character c)))
               (render-hershey-character renderer char)
               ))))

(defun trans (renderer x1 y1 x2 y2)
  (let ((x1_r (round (+ (* *scale* x1) *offset-x*)))
        (y1_r (round (+ (* *scale* y1) *offset-y*)))
        (x2_r (round (+ (* *scale* x2) *offset-x*)))
        (y2_r (round (+ (* *scale* y2) *offset-y*))))
    (sdl2:render-draw-line renderer x1_r y1_r x2_r y2_r)))
