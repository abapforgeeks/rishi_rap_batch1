FUNCTION zrishi_purchase_data_save.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_PURCHASE_CREATE) TYPE
*"        ZRSH_IF_RAP_BATCH1=>TT_DB_PURCHASE
*"     VALUE(IT_PURCHASE_DELETE) TYPE
*"        ZRSH_IF_RAP_BATCH1=>TT_DB_PURCHASE
*"     VALUE(IT_PURCHASE_UPDATE) TYPE
*"        ZRSH_IF_RAP_BATCH1=>TT_DB_PURCHASE
*"     VALUE(IT_PURCHASE_ITEMS) TYPE
*"        ZRSH_IF_RAP_BATCH1=>TT_DB_PO_ITEMS
*"----------------------------------------------------------------------
  IF it_purchase_create IS NOT INITIAL.
    INSERT zrishi_podoc FROM TABLE @it_purchase_create.
  ENDIF.

  IF it_purchase_delete IS NOT INITIAL.
    DELETE zrishi_podoc FROM TABLE @it_purchase_delete.
  ENDIF.

  IF it_purchase_update IS NOT INITIAL.
    UPDATE zrishi_podoc FROM TABLE @it_purchase_update.
  ENDIF.

  IF it_purchase_items IS NOT INITIAL.
    INSERT zrishi_poitem FROM TABLE @it_purchase_items.
  ENDIF.

ENDFUNCTION.
