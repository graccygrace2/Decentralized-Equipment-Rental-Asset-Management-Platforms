;; Equipment Owner Verification Contract
;; Validates equipment rental companies and manages their verification status

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_ALREADY_VERIFIED (err u101))
(define-constant ERR_NOT_VERIFIED (err u102))
(define-constant ERR_INVALID_COMPANY (err u103))

;; Data structures
(define-map verified-companies
  { company-id: uint }
  {
    owner: principal,
    company-name: (string-ascii 100),
    registration-number: (string-ascii 50),
    verified-at: uint,
    is-active: bool
  }
)

(define-map company-counter principal uint)
(define-data-var next-company-id uint u1)

;; Public functions
(define-public (register-company (company-name (string-ascii 100)) (registration-number (string-ascii 50)))
  (let ((company-id (var-get next-company-id)))
    (map-set verified-companies
      { company-id: company-id }
      {
        owner: tx-sender,
        company-name: company-name,
        registration-number: registration-number,
        verified-at: block-height,
        is-active: true
      }
    )
    (map-set company-counter tx-sender company-id)
    (var-set next-company-id (+ company-id u1))
    (ok company-id)
  )
)

(define-public (verify-company (company-id uint))
  (if (is-eq tx-sender CONTRACT_OWNER)
    (match (map-get? verified-companies { company-id: company-id })
      company-data (begin
        (map-set verified-companies
          { company-id: company-id }
          (merge company-data { is-active: true })
        )
        (ok true)
      )
      ERR_INVALID_COMPANY
    )
    ERR_UNAUTHORIZED
  )
)

(define-public (deactivate-company (company-id uint))
  (if (is-eq tx-sender CONTRACT_OWNER)
    (match (map-get? verified-companies { company-id: company-id })
      company-data (begin
        (map-set verified-companies
          { company-id: company-id }
          (merge company-data { is-active: false })
        )
        (ok true)
      )
      ERR_INVALID_COMPANY
    )
    ERR_UNAUTHORIZED
  )
)

;; Read-only functions
(define-read-only (get-company-info (company-id uint))
  (map-get? verified-companies { company-id: company-id })
)

(define-read-only (is-company-verified (company-id uint))
  (match (map-get? verified-companies { company-id: company-id })
    company-data (get is-active company-data)
    false
  )
)

(define-read-only (get-company-by-owner (owner principal))
  (map-get? company-counter owner)
)
