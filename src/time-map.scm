(use-modules ((rnrs) :version(6)))
(use-modules (opencog) (opencog atom-types))
(use-modules (opencog ato pointmem)); needed for mapsi
(use-modules (opencog python))
;;initialize octomap with 15hz, 10 second or 150 frames buffer ; 1 cm spatial resolution
(create-map "faces" 0.01 (div 1000 15) 150) (step-time-unit "faces")(auto-step-time-on "faces")
;;scm code
(define-public (look-at-face face-id-node)
		(let* ((loc-atom (get-past-locs-ato "faces" face-id-node 1) ))
			;(display "*************face\n")
			;(display (cog-name face-id-node))
			(if (equal? (cog-atom (cog-undefined-handle)) loc-atom) (list 0.0) 
				(let* ((loc-link (car (cog-outgoing-set loc-atom)))
					(xx (loc-link-x loc-link))
					(yy (loc-link-y loc-link))
					(zz (loc-link-z loc-link))) 
						(list xx yy zz))
			)
		)
)

