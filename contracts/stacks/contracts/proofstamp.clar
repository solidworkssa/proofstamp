;; ────────────────────────────────────────
;; ProofStamp v1.0.0
;; Author: solidworkssa
;; License: MIT
;; ────────────────────────────────────────

(define-constant VERSION "1.0.0")

;; Error codes
(define-constant ERR-NOT-AUTHORIZED (err u401))
(define-constant ERR-NOT-FOUND (err u404))
(define-constant ERR-ALREADY-EXISTS (err u409))
(define-constant ERR-INVALID-INPUT (err u422))

;; ProofStamp Clarity Contract
;; Decentralized document verification and timestamping.


(define-map proofs
    (buff 32)
    {
        owner: principal,
        timestamp: uint,
        metadata-uri: (string-utf8 256)
    }
)

(define-public (stamp (document-hash (buff 32)) (metadata-uri (string-utf8 256)))
    (let
        (
            (exists (is-some (map-get? proofs document-hash)))
        )
        (asserts! (not exists) (err u100)) ;; Already exists
        (map-set proofs document-hash {
            owner: tx-sender,
            timestamp: block-height,
            metadata-uri: metadata-uri
        })
        (ok true)
    )
)

(define-read-only (verify (document-hash (buff 32)))
    (ok (map-get? proofs document-hash))
)

