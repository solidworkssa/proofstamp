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

