CLASS lcl_trbuffer DEFINITION.
  PUBLIC SECTION.
    TYPES: BEGIN OF lty_po_buffer.
             INCLUDE TYPE zrishi_podoc AS data.
    TYPES:   flag TYPE abap_boolean.
    TYPES:    END OF lty_po_buffer.
    CLASS-DATA: mt_purchasedoc_buffer TYPE TABLE OF lty_po_buffer.
ENDCLASS.


CLASS lhc_ZI_RISHI_PURCHASEDOC_U DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create_purchaseorder FOR MODIFY
      IMPORTING it_purchase_docs FOR CREATE zi_rishi_purchasedoc_u.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zi_rishi_purchasedoc_u.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zi_rishi_purchasedoc_u.

    METHODS read FOR READ
      IMPORTING keys FOR READ zi_rishi_purchasedoc_u RESULT result.

ENDCLASS.

CLASS lhc_ZI_RISHI_PURCHASEDOC_U IMPLEMENTATION.

  METHOD create_purchaseorder.

    DATA: ls_purchase_doc TYPE zrishi_podoc.
    "Fetch already existing Purchase Order Number
    SELECT MAX( po_document  ) FROM zrishi_podoc INTO @DATA(lv_max_pono).

    "Mapping CDS Tables to the back end table fields.
    LOOP AT it_purchase_docs ASSIGNING FIELD-SYMBOL(<Lfs_podoc>).
      ls_purchase_doc = CORRESPONDING #(  <lfs_podoc> MAPPING FROM ENTITY ).
      "Update Date Time Information
      GET TIME STAMP FIELD DATA(lv_create_change_time).
      ls_purchase_doc-created_date_time = lv_create_change_time.
      ls_purchase_doc-create_by = sy-uname.
      ls_purchase_doc-changed_date_time = lv_create_change_time.
      "increment PODOC.
      ls_purchase_doc-po_document = lv_max_pono + 1.
      "Buffering the transaction data, by adding flag 'C' Create Mode.
      APPEND VALUE #( flag = 'C' data = CORRESPONDING #( ls_purchase_doc ) ) TO lcl_trbuffer=>mt_purchasedoc_buffer.
    ENDLOOP.

  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_RISHI_PURCHASEDOC_U DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS check_before_save REDEFINITION.

    METHODS finalize          REDEFINITION.

    METHODS save              REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_RISHI_PURCHASEDOC_U IMPLEMENTATION.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD finalize.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

ENDCLASS.
