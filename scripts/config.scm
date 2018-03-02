(use-modules (opencog)
             (opencog nlp relex2logic)
             (opencog openpsi)
             (opencog exec)
             (opencog movement)
             (opencog ghost))

; Load rules: The following is just a placeholder, a module of the rulebase
; should be loaded instead.
(ghost-parse "s: (hi robot) Hello human ^keep")

; Start the ghost loop
(ghost-run)
