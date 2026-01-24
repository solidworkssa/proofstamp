;; ProofStamp - Document Verification Registry (Clarity v4)

(define-data-var document-count uint u0)

(define-map documents
    (buff 32)
    {
        submitter: principal,
        block-height: uint,
        metadata: (string-utf8 256),
        exists: bool
    }
)

(define-map user-documents
    {user: principal, index: uint}
    (buff 32)
)

(define-map user-document-count
    principal
    uint
)

(define-constant ERR-ALREADY-EXISTS (err u100))
(define-constant ERR-NOT-FOUND (err u101))
(define-constant ERR-INVALID-HASH (err u102))

(define-public (register-document (document-hash (buff 32)) (metadata (string-utf8 256)))
    (let
        (
            (user-count (default-to u0 (map-get? user-document-count tx-sender)))
        )
        (asserts! (> (len document-hash) u0) ERR-INVALID-HASH)
        (asserts! (is-none (map-get? documents document-hash)) ERR-ALREADY-EXISTS)
        
        (map-set documents document-hash {
            submitter: tx-sender,
            block-height: block-height,
            metadata: metadata,
            exists: true
        })
        
        (map-set user-documents {user: tx-sender, index: user-count} document-hash)
        (map-set user-document-count tx-sender (+ user-count u1))
        (var-set document-count (+ (var-get document-count) u1))
        
        (ok true)
    )
)

(define-read-only (verify-document (document-hash (buff 32)))
    (ok (map-get? documents document-hash))
)

(define-read-only (get-user-document (user principal) (index uint))
    (ok (map-get? user-documents {user: user, index: index}))
)

(define-read-only (get-user-document-count (user principal))
    (ok (default-to u0 (map-get? user-document-count user)))
)

(define-read-only (get-total-documents)
    (ok (var-get document-count))
)
