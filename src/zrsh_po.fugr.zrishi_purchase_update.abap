FUNCTION zrishi_purchase_update.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_PURCHASE_DOC) TYPE  ZRSH_IF_RAP_BATCH1=>TT_DB_PURCHASE
*"     VALUE(IT_PURCHASE_CONTROL) TYPE
*"        ZRSH_IF_RAP_BATCH1=>TT_PURCHASE_CONTROL
*"  EXPORTING
*"     VALUE(ET_PURCHASE_UPDATE) TYPE
*"        ZRSH_IF_RAP_BATCH1=>TT_DB_PURCHASE
*"     VALUE(ET_MESSAGES) TYPE  BAPIRETTAB
*"----------------------------------------------------------------------

  DATA: lv_index TYPE i.

  SELECT * FROM zrishi_podoc
  FOR ALL ENTRIES IN @it_purchase_doc
  WHERE po_document EQ @it_purchase_doc-po_document
  INTO TABLE @DATA(lt_purchase_db).
  IF sy-subrc EQ 0.
    LOOP AT it_purchase_doc ASSIGNING FIELD-SYMBOL(<lfs_purchase_current>).

      READ TABLE lt_purchase_db INTO DATA(ls_purchase_db) WITH KEY po_document = <lfs_purchase_current>-po_document.
      IF sy-subrc EQ 0.
        GET TIME STAMP FIELD DATA(lv_timestamp) .
        ls_purchase_db-changed_date_time = lv_timestamp.
        APPEND ls_purchase_db TO et_purchase_update ASSIGNING FIELD-SYMBOL(<lfs_purchase_update>).
      ENDIF.
      lv_index = 2.
      READ TABLE it_purchase_control INTO DATA(ls_purchase_control) WITH KEY PurchaseDocument = <lfs_purchase_current>-po_document.
      DO.
        ASSIGN COMPONENT lv_index OF STRUCTURE ls_purchase_control TO FIELD-SYMBOL(<lfs_flag>).
        IF sy-subrc <> 0.
          EXIT.
        ENDIF.
        IF <lfs_flag> EQ abap_true.
          ASSIGN COMPONENT lv_index OF STRUCTURE <lfs_purchase_current> TO FIELD-SYMBOL(<lfs_current_value>).
          ASSIGN COMPONENT lv_index OF STRUCTURE <lfs_purchase_update> TO FIELD-SYMBOL(<lfs_db>).
          <lfs_db> = <lfs_current_value>.

        ENDIF.
        lv_index = lv_index + 1.
      ENDDO.

    ENDLOOP.
  ENDIF.





ENDFUNCTION.
