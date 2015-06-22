;;; key-seq.el - map pairs of sequentially pressed keys to commands

;; Copyright (C) 2013 Vyacheslav Levit
;; Copyright (C) 2003,2005,2008,2012 David Andersson

;; Author: Vyacheslav Levit <dev@vlevit.org>
;; Maintainer: Vyacheslav Levit <dev@vlevit.org>
;; Version: 1.0.0
;; Created: 15 June 2015
;; Package-Requires: ((key-chord "0.6"))
;; Keywords: convenience keyboard keybindings
;; URL: http://github.com/vlevit/key-seq.el

;; This file is NOT part of Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA

;;; Commentary:

;; This package provides interactive functions to map pairs of
;; sequentially and quickly pressed keys to commands:
;;
;;  - `key-seq-define-global' defines a pair in the global key-map,
;;  - `key-seq-define' defines a pair in a specific key-map.
;;
;; The package depends on key-chord.el and to work it requires active
;; key-chord-mode. Add this line to your configuration:
;;
;;    (key-chord-mode 1)
;;
;; The only difference between key-chord-* functions and key-seq-*
;; functions is that the latter executes commands only if the order of
;; pressed keys matches the order of defined bindings. For example,
;; with the following binding
;;
;;    (key-seq-define-global "qd" 'dired)
;;
;; dired shall be run if you press `q' and `d' only in that order
;; while if you define the binding with `key-seq-define-global' both
;; `qd' and `dq' shall run dired.
;;
;; For more information and various customizations see key-chord.el
;; documentation.

;;; Code:

;;;###autoload
(defun key-seq-define-global (keys command)
  "Like key-chord-define-global but the order of keys matters."
  (interactive "sSet key chord globally (2 keys): \nCSet chord \"%s\" to command: ")
  (key-seq-define (current-global-map) keys command))

;;;###autoload
(defun key-seq-define (keymap keys command)
  "Like key-chord-define but the order of keys matters."
  (if (/= 2 (length keys))
      (error "Key-chord keys must have two elements"))
  ;; Exotic chars in a string are >255 but define-key wants 128..255 for those
  (let ((key1 (logand 255 (aref keys 0)))
        (key2 (logand 255 (aref keys 1))))
    (if (eq key1 key2)
        (define-key keymap (vector 'key-chord key1 key2) command)
      (define-key keymap (vector 'key-chord key1 key2) command))))

(provide 'key-seq)

;;; key-seq.el ends here
