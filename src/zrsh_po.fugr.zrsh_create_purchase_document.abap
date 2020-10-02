FUNCTION zrsh_create_purchase_document.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_PURCHASE_DOCS) TYPE  ANY TABLE
*"  EXPORTING
*"     VALUE(ET_PURCHASE_DOCS) TYPE
*"        ZRSH_IF_RAP_BATCH1=>TT_PURCHASE_DOCS
*"     VALUE(ET_MESSAGES) TYPE  BAPIRETTAB
*"----------------------------------------------------------------------

  DATA: ls_purchase_doc TYPE ZI_Rishi_PurchaseDoc.

  "Fetch already existing Purchase Order Number
  SELECT MAX( po_document  ) FROM zrishi_podoc INTO @DATA(lv_max_pono).
  DATA(lv_purchase_doc) = CONV zebeln( lv_max_pono + 1 ).
*      lv_purchase_doc =  |{ lv_purchase_doc ALPHA = IN }|.
  "Mapping CDS Tables to the back end table fields.
  LOOP AT it_purchase_docs ASSIGNING FIELD-SYMBOL(<Lfs_podoc>).

    MOVE-CORRESPONDING <lfs_podoc> to ls_purchase_doc.
    "Update Date Time Information
    GET TIME STAMP FIELD DATA(lv_create_change_time).
    ls_purchase_doc-CreatedOn = lv_create_change_time.
    ls_purchase_doc-CreatedBy = sy-uname.
    ls_purchase_doc-ChangedBy = lv_create_change_time.
    "increment PODOC.
    ls_purchase_doc-PurchaseDocument = condense( lv_purchase_doc ).

    "Final Internal table.
    APPEND VALUE #( data = CORRESPONDING #( ls_purchase_doc ) ) TO et_purchase_docs.
  ENDLOOP.


ENDFUNCTION.
