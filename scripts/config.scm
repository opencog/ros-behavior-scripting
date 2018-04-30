(use-modules (opencog)
             (opencog cogserver)
             (opencog logger)
             (opencog nlp)
             (opencog nlp relex2logic)
             (opencog openpsi)
             (opencog attention)
             (opencog eva-behavior)
             (opencog ghost)
             (opencog ghost procedures))

(ecan-based-ghost-rules #t)
(set-relex-server-host)
(ghost-run)


; (define (single-rule)
;   (use-modules (opencog eva-behavior))
;   ; Load rules: The following is just a placeholder, a module of the rulebase
;   ; should be loaded instead.
;   (ghost-parse "s: (hi robot) Hello human")
;
; )
; (define (multiple-rules)
;   (use-modules (opencog eva-behavior))
;   (ghost-parse-file "test.ghost")
; )
;
; (define (ros-multiple-rules)
;   (use-modules (opencog movement))
;   (ghost-parse-file "test.ghost")
; )

; TODO: change to command-line argument.
; (define ghost-rule-base 1)
; (case ghost-rule-base
;   ((1) (single-rule))
;   ((2) (multiple-rules))
;   ((3) (ros-multiple-rules))
; )

(start-cogserver "opencog.conf")
(cog-logger-set-stdout! #f)

; Start the ghost loop
(ghost-run)
