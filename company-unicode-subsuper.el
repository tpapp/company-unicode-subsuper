;;; company-unicode-subsuper.el ---                  -*- lexical-binding: t; -*-

;; Copyright (C) 2017  Tamas Papp
;; Author: Tamas Papp <tkpapp@gmail.com>
;; Keywords: completions, Unicode
;; License: GPL
;; Version: 0.1
;; Package-Requires: ((company "0.8.0")

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(require 'company)

(defconst company-unicode-subsuper--regex
  (rx (or "_" "^") (zero-or-more (or alnum (char "()+-="))))
  "Regex for matching super- and subscripts recognized.")

(defun company-unicode-subsuper--entry (char &optional name-table)
  "Create an entry from CHAR for the lookup table. By default, the string used for entering the character is prefixed by _ or ^ for sub- and superscripts, respectively, but NAME-TABLE can be used to provide a different translation (eg for Greek letters)."
  (cl-flet ((entry (string replacement)
                (add-text-properties 0 1 `(:unicode ,replacement) string)
                string)
            (lookup-name (orig-char)
                    (alist-get orig-char name-table (string orig-char))))
    (pcase (get-char-code-property char 'decomposition)
      (`(super ,orig-char) (entry (format "^%s" (lookup-name orig-char)) char))
      (`(sub ,orig-char) (entry (format "_%s" (lookup-name orig-char)) char))
      (_ (error "Character %c is not a sub- or superscript.") char))))

(defconst company-unicode-name-table
  '((?β . "beta")
    (?γ . "gamma")
    (?δ . "delta")
    (?θ . "theta")
    (?ι . "iota")
    (?φ . "varphi")
    (?χ . "chi"))
  "Table for entering characters outside the ASCII range. Follows conventions of LaTeX, but without the \\ prefix.")

(defconst company-unicode-subsuper-table
  (mapcar (lambda (c)
            (company-unicode-subsuper--entry c company-unicode-name-table))
          (string-to-list
           (concat
            ;; numbers and operators
            "₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎" "⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾"
            ;; capital letters - only superscript
            "ᴬᴮᴰᴱᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾᴿᵀᵁⱽᵂ"
            ;; small letters
            "ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻ" "ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓ"
            ;;greek letters
            "ᵝᵞᵟᶿᶥᵠᵡ" "ᵦᵧᵨᵩᵪ")))
  "A list of completions recognized. The :UNICODE property of each provides the substitition.

List compiled from Wikipedia, https://en.wikipedia.org/wiki/Unicode_subscripts_and_superscripts")

(defun company-unicode-subsuper--substitute (arg)
  "Replace ARG before point with its :UNICODE property."
  (let* ((pos (point))
         (start (- pos (length arg))))
    (when (equal (buffer-substring start pos) arg)
      (delete-region start pos)
      (insert (get-text-property 0 :unicode arg)))))

(defun company-unicode-subsuper (command &optional arg &rest ignored)
  "Company backend for typing Unicode super- and subscripts.

Use _ and ^ before the letter or string, eg _a, ^+, etc. Note that the Greek letters are typed as _beta and similar, without the \\ you would use in LaTeX.

Only a small subset of letters have Unicode super- and subscript equivalents, see the definition of COMPANY-UNICODE-SUBSUPER-TABLE for a full list. You need a font that supports the relevant Unicode characters."
  (interactive (list 'interactive))
  (case command
    (interactive (company-begin-backend 'company-unicode-subsuper))
    (prefix (when (looking-back company-unicode-subsuper--regex (point-at-bol))
              (match-string 0)))
    ;; a space is added to each candidate to allow replacement of the full form.
    ;; workaround for https://github.com/company-mode/company-mode/issues/476
    (candidates (mapcar (lambda (candidate) (concat candidate " "))
                        (all-completions arg
                                         company-unicode-subsuper-table)))
    (post-completion (company-unicode-subsuper--substitute arg))))

(provide 'company-unicode-subsuper)
;;; company-unicode-subsuper.el ends here

;; Local Variables:
;; eval: (visual-line-mode 1)
;; End:
