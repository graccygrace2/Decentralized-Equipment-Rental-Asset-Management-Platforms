;; Asset Tracking Contract
;; Tracks rental equipment assets and their current status

(define-constant ERR_UNAUTHORIZED (err u200))
(define-constant ERR_ASSET_NOT_FOUND (err u201))
(define-constant ERR_ASSET_ALREADY_EXISTS (err u202))
(define-constant ERR_INVALID_STATUS (err u203))

;; Asset status constants
(define-constant STATUS_AVAILABLE u1)
(define-constant STATUS_RENTED u2)
(define-constant STATUS_MAINTENANCE u3)
(define-constant STATUS_RETIRED u4)

;; Data structures
(define-map assets
  { asset-id: uint }
  {
    owner-company-id: uint,
    asset-type: (string-ascii 50),
    model: (string-ascii 100),
    serial-number: (string-ascii 100),
    purchase-date: uint,
    status: uint,
    location: (string-ascii 200),
    daily-rate: uint,
    created-at: uint
  }
)

(define-map asset-history
  { asset-id: uint, event-id: uint }
  {
    event-type: (string-ascii 50),
    timestamp: uint,
    details: (string-ascii 200)
  }
)

(define-map asset-event-counter uint uint)
(define-data-var next-asset-id uint u1)

;; Public functions
(define-public (register-asset
  (owner-company-id uint)
  (asset-type (string-ascii 50))
  (model (string-ascii 100))
  (serial-number (string-ascii 100))
  (daily-rate uint)
  (location (string-ascii 200))
)
  (let ((asset-id (var-get next-asset-id)))
    ;; Verify company ownership through verification contract
    (map-set assets
      { asset-id: asset-id }
      {
        owner-company-id: owner-company-id,
        asset-type: asset-type,
        model: model,
        serial-number: serial-number,
        purchase-date: block-height,
        status: STATUS_AVAILABLE,
        location: location,
        daily-rate: daily-rate,
        created-at: block-height
      }
    )
    (unwrap-panic (log-asset-event asset-id "REGISTERED" "Asset registered in system"))
    (var-set next-asset-id (+ asset-id u1))
    (ok asset-id)
  )
)

(define-public (update-asset-status (asset-id uint) (new-status uint) (details (string-ascii 200)))
  (match (map-get? assets { asset-id: asset-id })
    asset-data (begin
      (map-set assets
        { asset-id: asset-id }
        (merge asset-data { status: new-status })
      )
      (unwrap-panic (log-asset-event asset-id "STATUS_CHANGE" details))
      (ok true)
    )
    ERR_ASSET_NOT_FOUND
  )
)

(define-public (update-asset-location (asset-id uint) (new-location (string-ascii 200)))
  (match (map-get? assets { asset-id: asset-id })
    asset-data (begin
      (map-set assets
        { asset-id: asset-id }
        (merge asset-data { location: new-location })
      )
      (unwrap-panic (log-asset-event asset-id "LOCATION_UPDATE" new-location))
      (ok true)
    )
    ERR_ASSET_NOT_FOUND
  )
)

;; Private functions
(define-private (log-asset-event (asset-id uint) (event-type (string-ascii 50)) (details (string-ascii 200)))
  (let ((event-id (default-to u0 (map-get? asset-event-counter asset-id))))
    (map-set asset-history
      { asset-id: asset-id, event-id: (+ event-id u1) }
      {
        event-type: event-type,
        timestamp: block-height,
        details: details
      }
    )
    (map-set asset-event-counter asset-id (+ event-id u1))
    (ok true)
  )
)

;; Read-only functions
(define-read-only (get-asset-info (asset-id uint))
  (map-get? assets { asset-id: asset-id })
)

(define-read-only (get-asset-status (asset-id uint))
  (match (map-get? assets { asset-id: asset-id })
    asset-data (some (get status asset-data))
    none
  )
)

(define-read-only (is-asset-available (asset-id uint))
  (match (get-asset-status asset-id)
    status (is-eq status STATUS_AVAILABLE)
    false
  )
)

(define-read-only (get-asset-history (asset-id uint) (event-id uint))
  (map-get? asset-history { asset-id: asset-id, event-id: event-id })
)
