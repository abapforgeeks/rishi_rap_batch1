INTERFACE zrsh_if_rap_batch1
  PUBLIC .
  "Global Table types
  TYPES: BEGIN OF gty_purchase_doc.
           INCLUDE TYPE zi_rishi_purchasedoc_u AS data.
  TYPES: END OF gty_purchase_doc.

  TYPES: tt_db_purchase TYPE TABLE of zrishi_podoc.

  TYPES: BEGIN OF gty_purchase_items.
           INCLUDE TYPE ZI_Rishi_PurchaseItems AS data.
  TYPES: END OF gty_purchase_items.

  "Table Types for reuse
  TYPES: tt_purchase_docs  TYPE TABLE OF gty_purchase_doc,
         tt_purchase_items TYPE TABLE OF gty_purchase_items.
  "structure.
  TYPES: ts_purchase_doc  TYPE gty_purchase_doc,
         ts_purchase_item TYPE gty_purchase_items.

ENDINTERFACE.
