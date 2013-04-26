;; -*- emacs-lisp -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; $Id: calendar.el,v 1.16 2006/03/06 12:07:06 ole Exp $
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;_* Calendar related stuff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst calendar-etc-dir (expand-file-name "calendar/" emacs-etc-dir)
  "Directory for calendar related files")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;_* Calendar and Planner Keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar calendar-keymap (make-sparse-keymap "Appt: (a)dd/(d)elete, (c)alendar, (dD)iary, (n)ote, (p)lan, (t)ask")
  "Keymap used to globally access calendar and planner related functions")
(define-key mode-specific-map [?c] calendar-keymap)
(define-key calendar-keymap [??] 'describe-prefix-bindings)

(define-key calendar-keymap [?a] 'appt-add)    ;; add appointment
(define-key calendar-keymap [?A] 'appt-delete) ;; delete appointment

(define-key calendar-keymap [?d] 'diary) ;; show fancy diary
(define-key calendar-keymap [?D] 'show-all-diary-entries) ;; show raw diary
(define-key calendar-keymap [?c] 'calendar) ;; show calendar

(define-key calendar-keymap [?p] 'plan)
(define-key calendar-keymap [?t] 'planner-create-task-from-buffer)
(define-key calendar-keymap [?n] 'planner-create-note)

(define-key calendar-keymap [?v] 'remember)
(define-key calendar-keymap [?r] 'remember-region)
(define-key calendar-keymap [?b] 'remember-buffer)
(define-key calendar-keymap [?u] 'remember-url)
(define-key calendar-keymap [?l] 'remember-location)

(define-key calendar-keymap [?f] 'planner-goto-plan-page)
(define-key calendar-keymap [?w] 'emacs-wiki-find-file)
(define-key calendar-keymap [?j] 'emacs-wiki-journal-add-entry-other-window)

(define-key goto-keymap [?p] 'plan)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; time display in modeline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'time)

;; display time in 24 hr format
(setq display-time-24hr-format t)

;; turn on time display in modeline
(display-time)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;_* Appointments
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'appt)

;; Turn on warnings.
(setq appt-issue-message t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; calendar 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'calendar)

;; European dates, with the date in front of the month.
(european-calendar)

(setq calendar-week-start-day 1
      calendar-day-name-array ["Sonntag" "Montag" "Dienstag" "Mittwoch"
                               "Donnerstag" "Freitag" "Samstag"]
      calendar-month-name-array ["Januar" "Februar" "März" "April" "Mai"
                                 "Juni" "Juli" "August" "September"
                                 "Oktober" "November" "Dezember"])

;; Some holidays which are more European than the American defaults.
(setq general-holidays
      '((holiday-fixed 1 1   "Neujahr")
        (holiday-fixed 1 6   "Dreikönig")
        (holiday-fixed 2 14  "Valentinstag")
        (holiday-fixed 3 17  "St. Patrick's Day")
        (holiday-fixed 4 1   "1. April")
        (holiday-fixed 5 1   "Tag der Arbeit")
        (holiday-fixed 10 3  "Tag der Einheit")
        (holiday-fixed 11 1  "Allerheiligen")
        (holiday-fixed 11 11 "Martinstag")
        (holiday-fixed 12 6  "Nikolaus")
        (holiday-fixed 12 24 "Heiligabend")
        (holiday-fixed 12 26 "2. Weihnachtsfeiertag")
        (holiday-fixed 12 31 "Sylvester")
))

(setq local-holidays
      '((holiday-float 12 0 -1 "4. Advent" 24)
        (holiday-float 12 0 -2 "3. Advent" 24)
        (holiday-float 12 0 -3 "2. Advent" 24)
        (holiday-float 12 0 -4 "1. Advent" 24)
))


(setq calendar-holidays
      (append general-holidays local-holidays other-holidays
          christian-holidays solar-holidays))

;; set latitude and longitude for Weinheim, Germany
(setq calendar-location-name "Weinheim"
      calendar-latitude 49.554940
      calendar-longitude 8.671590)

;; Mark holidays and diary entries in calendar.
(setq mark-holidays-in-calendar t
      mark-diary-entries-in-calendar t)

;; Mark current day on calendar.
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)

(defun calendar-goto-iso-week (week year)
  "Move cursor to ISO week number WEEK of year YEAR.
Interactively uses the \"current\" year and just asks for a week
number."
  (interactive
   (progn 
     (require 'cal-iso)
     (let* ((year (extract-calendar-year (calendar-cursor-to-date t)))
            (no-weeks (extract-calendar-month
                       (calendar-iso-from-absolute
                        (1-
                         (calendar-dayname-on-or-before
                          1 (calendar-absolute-from-gregorian
                             (list 1 4 (1+ year))))))))
            (week (calendar-read
                   (format "ISO calendar week (1-%d): " no-weeks)
                   '(lambda (x) (and (> x 0) (<= x no-weeks))))))
       (list week year))))
  (calendar-goto-iso-date (list week calendar-week-start-day year)))

(define-key calendar-mode-map "gw" 'calendar-goto-iso-week)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; diary
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'cal-desk-calendar)

(setq diary-schedule-interval-time 60
      diary-schedule-expand-grid t
      diary-default-schedule-start-time 1000
      diary-default-schedule-stop-time  1800
      diary-schedule-start-time 1000
      diary-schedule-stop-time 1800)

;; (setq diary-display-hook nil)
;; (add-hook 'diary-display-hook 'fancy-schedule-display-desk-calendar t)
;;(add-hook 'diary-display-hook 'sort-diary-entries)
(add-hook 'diary-display-hook 'fancy-diary-display)

;; Use a slightly nonstandard diary file.
(setq diary-file (expand-file-name "diary" calendar-etc-dir))

;; This combination should be OK.
(setq diary-list-include-blanks nil)
(setq number-of-diary-entries 1)

;; Make sure diary entries are sorted, and includes are processed.
(add-hook 'list-diary-entries-hook 'include-other-diary-files)
(add-hook 'list-diary-entries-hook 'sort-diary-entries t)
(add-hook 'list-diary-entries-hook 'bbdb-include-anniversaries)

(autoload 'bbdb-include-anniversaries "bbdb-anniv"
  "Include bbdb anniversaries in diary.")

;; Mark diary entries on calendar.  Allow nested diary files and make
;; sure that entries from all files are marked on the calendar.
(add-hook 'mark-diary-entries-hook 'mark-included-diary-files)

(defun diary-schedule (m1 d1 y1 m2 d2 y2 dayname)
  "Entry applies if date is between dates on DAYNAME.  
    Order of the parameters is M1, D1, Y1, M2, D2, Y2 if
    `european-calendar-style' is nil, and D1, M1, Y1, D2, M2, Y2 if
    `european-calendar-style' is t. Entry does not apply on a history.
Example:
    &%%(diary-schedule 22 4 2003 1 8 2003 2) 18:00 History
"
  (let ((date1 (calendar-absolute-from-gregorian
                (if european-calendar-style
                    (list d1 m1 y1)
                  (list m1 d1 y1))))
        (date2 (calendar-absolute-from-gregorian
                (if european-calendar-style
                    (list d2 m2 y2)
                  (list m2 d2 y2))))
        (d (calendar-absolute-from-gregorian date)))
    (if (and 
         (<= date1 d) 
         (<= d date2)
         (= (calendar-day-of-week date) dayname)
         (not (check-calendar-holidays date))
         )
        entry)))

;; How to print the visible diary.
;(setq print-diary-entries-hook 'print-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;_* The Project Planner
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; (add-to-list 'load-path (expand-file-name "planner/" emacs-packages-dir))

(require 'planner)
;; (require 'planner-bbdb)
;; (require 'planner-diary)
;; (require 'planner-erc)
;; (require 'planner-gnus)
;; (require 'planner-id)
;; (require 'planner-notes-index)
;; (require 'planner-rss)
;; (require 'planner-cyclic)
;; (require 'planner-lisp)
;; (require 'planner-w3m)
;; (require 'planner-tasks-overview)
;; (require 'planner-experimental)
;; (require 'planner-accomplishments)
;; (require 'planner-schedule)
;; (require 'planner-timeclock)
;; (require 'planner-notes)
;; (require 'planner-browser)

(planner-install-extra-task-keybindings)
(setq planner-carry-tasks-forward  7
      planner-use-other-window     nil
      planner-annotation-strip-directory t
      planner-directory            "~/doc/plans"
      planner-publishing-directory "~/html/plans"
      planner-diary-string         "* Schedule"
      planner-plan-page-template   "* Overview\n\n\n* Notes\n\n\n* Tasks\n\n\n"
      planner-day-page-template    (concat "* Tasks\n\n\n" planner-diary-string "\n\n\n* Notes\n\n\n")
)

(add-to-list 'auto-mode-alist '(".*/doc/plans/.*$" . planner-mode))

(planner-option-customized 'planner-directory planner-directory)
(planner-option-customized 'planner-custom-variables
             '((planner-publishing-directory . "~/html/plans")
               ))

(defun planner-annotation-from-dired ()
  "Return the filename on the current line in dired"
  (when (planner-derived-mode-p 'dired-mode)
    (concat "[[" (dired-get-filename) "][file:" (dired-get-filename t) "]]")))

(add-hook 'planner-annotation-functions 'planner-annotation-from-dired)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;_ + Schedule 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(planner-calendar-insinuate)
;; (planner-diary-insinuate)

(setq planner-diary-cal-desk-string  planner-diary-string
      planner-diary-use-diary t
      planner-diary-use-private-diary nil
      planner-diary-use-public-diary nil
      planner-diary-use-appts nil
      planner-diary-use-cal-desk nil)

(defun planner-diary-add-entry (date time text)
  "Prompt for a diary entry to add to `diary-file'.  Will run
   planner-annotations to make hyper links"
  (interactive (list (planner-read-date)
                     (read-string "Time: ")
                     (read-string "Diary entry: ")))
  (save-excursion
    (save-window-excursion
      (make-diary-entry
       (concat
        (let ((cal-date (planner-filename-to-calendar-date date)))
          (if european-calendar-style
              (format "%d/%d/%d"
                      (elt cal-date 1)
                      (elt cal-date 0)
                      (elt cal-date 2))
            (format "%d/%d/%d"
                    (elt cal-date 0)
                    (elt cal-date 1)
                    (elt cal-date 2))))
        " " time " " text " "
        (run-hook-with-args-until-success
         'planner-annotation-functions))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;_* Blog RSS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq planner-rss-initial-contents
      "<?xml version=\"1.0\" encoding=\"8859-1\"?>
  <rss version=\"2.0\">
    <channel>
      <title>Sugarshark's musings</title>
      <link>http://sugarshark.com/JournalPage.html</link>
      <description>Random notes</description>
    </channel>
  </rss>"
      planner-rss-base-url "http://sugarshark.com/journal/"
      planner-rss-file-name "/home/ole/html/plans/blog.rdf"
      )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;_* Bibl
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path (expand-file-name "bibl-mode" emacs-packages-dir))
(require 'bibl-mode)
(setq bibl-file-name (expand-file-name "~/doc/bibliography"))
(add-to-list 'auto-mode-alist '("bibliography$" . bibl-mode))
(bibl-update-record-fields)

(define-key mode-specific-map [?b]  'bibl-global-map)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;_* Remember
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path (expand-file-name "remember/" emacs-packages-dir))

(require 'remember)
(require 'remember-bbdb)
(require 'remember-bibl)
(require 'remember-planner)
(require 'remember-diary)
(require 'remember-emacs-wiki-journal)

;; Use BBDB to complete names and addresses
(setq remember-use-bbdb t
      remember-handler-functions '(remember-diary-extract-entries
                                   remember-emacs-wiki-journal-add-entry-maybe
                                   remember-planner-append)
      remember-annotation-functions planner-annotation-functions
      remember-save-after-remembering t
      ;; describe-function: format-time-string
      remember-planner-timestamp-format "\n*** Note taken on %A, %d.%m.%Y at %H:%M %Z"
      ;; possible functions:
      ;;     remember-planner-add-timestamp,
      ;;     remember-planner-add-xref
      ;;     planner-rss-add-note
      remember-append-to-planner-hook '(remember-planner-add-xref
                                        planner-rss-add-note)
      )

(defun my-remember-mode-hook ()
  "Switch wiki mode on in the remember buffer"
  (emacs-wiki-mode)
  (use-local-map remember-mode-map)
  (setq major-mode 'remember-mode
        mode-name "Remember"))

;; (setq remember-mode-hook nil)
(add-hook 'remember-mode-hook 'my-remember-mode-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;_* Remembrance agent
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'remem)

;; (setq remem-prog-dir (expand-file-name "/usr/bin/"))
;; (setq remem-database-dir (expand-file-name "~/.ra-index"))

;; (setq remem-scopes-list '(("mail" 3 6 300)
;;                        ("doc" 3 10 300)))


