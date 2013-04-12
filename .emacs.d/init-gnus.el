;;; init-gnus.el ---

(provide 'init-gnus)


(eval-after-load "mail-source" '(require 'pop3))

(setq smtpmail-debug-info t)
(setq pop3-debug t)
(setq gnus-secondary-select-methods '((nnml "")))

(setq user-full-name "Keith Avery")
(setq user-full-mail-address "kavery@flatworldknowledge.com")

(setq mail-sources
      '(;
        (pop :server "pop.gmail.com"
             :port 995
             :user "kavery@flatworldknowledge.com"
             :connection ssl
:password "Beanp0wer"
             :leave t)))

;; Sending mail
(setq message-send-mail-function 'smtpmail-send-it)
(setq smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil)))
(setq smtpmail-auth-credentials '(("smtp.gmail.com" 587 "kavery@flatworldknowledge.com"
 nil)))
(setq smtpmail-default-smtp-server "smtp.gmail.com")
(setq smtpmail-smtp-server "smtp.gmail.com")
(setq smtpmail-smtp-service 587)

(setq gnus-visible-headers
      '("^From" "^Subject" "^Date"))

(gnus-add-configuration
 '(article
   (horizontal 1.0
               (vertical 25
                         (group 1.0))
               (vertical 1.0
                         (summary 0.25 point)
                         (article 1.0)))))
(gnus-add-configuration
 '(summary
   (horizontal 1.0
               (vertical 25
                         (group 1.0))
               (vertical 1.0
                         (summary 1.0 point)))))


(add-to-list 'gnus-secondary-select-methods '(nnimap "gmail"
                                  (nnimap-address "imap.gmail.com")
                                  (nnimap-server-port 993)
                                  (nnimap-stream ssl)))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 25 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 25 "kavery@flatworldknowledge.com" "Beanp0wer"))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 25
      smtpmail-local-domain "flatworldknowledge.com")
