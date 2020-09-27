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
      IMPORTING it_delete_po FOR DELETE zi_rishi_purchasedoc_u.

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
      DATA(lv_purchase_doc) = CONV zebeln( lv_max_pono + 1 ).
*      lv_purchase_doc =  |{ lv_purchase_doc ALPHA = IN }|.
      "Mapping CDS Tables to the back end table fields.
      LOOP AT it_purchase_docs ASSIGNING FIELD-SYMBOL(<Lfs_podoc>).
      ls_purchase_doc = CORRESPONDING #(  <lfs_podoc> MAPPING FROM ENTITY ).
      "Update Date Time Information
      GET TIME STAMP FIELD DATA(lv_create_change_time).
      ls_purchase_doc-created_date_time = lv_create_change_time.
      ls_purchase_doc-create_by = sy-uname.
      ls_purchase_doc-changed_date_time = lv_create_change_time.
      "increment PODOC.
      ls_purchase_doc-po_document = condense( lv_purchase_doc ).

      "Buffering the transaction data, by adding flag 'C' Create Mode.
      APPEND VALUE #( flag = 'C' data = CORRESPONDING #( ls_purchase_doc ) ) TO lcl_trbuffer=>mt_purchasedoc_buffer.
      APPEND VALUE #( %cid = <lfs_podoc>-%cid purchasedocument = ls_purchase_doc-po_document  ) to mapped-zi_rishi_purchasedoc_u.
        DATA(lref_message) = NEW cl_abap_behv( )->new_message(
                                                        id       =  'ZRISHI_MSG'
                                                        number   = '001'
                                                        severity = if_abap_behv_message=>severity-success
                                                          ).
        APPEND VALUE #( %cid = <lfs_podoc>-%cid purchasedocument = lv_purchase_doc  %msg = lref_message ) TO reported-zi_rishi_purchasedoc_u.

    ENDLOOP.

*    DATA(lref_message) = NEW cl_abap_behv( )->new_message(
*                                                    id       =  'ZRISHI_MSG'
*                                                    number   = '001'
*                                                    severity = if_abap_behv_message=>severity-success
*                                                      ).
*    APPEND VALUE #( %cid = ls_purchase_doc-po_document %msg = lref_message ) TO reported-zi_rishi_purchasedoc_u.


  ENDMETHOD.

  METHOD delete.
    IF it_delete_po IS NOT INITIAL.

      LOOP AT it_delete_po ASSIGNING FIELD-SYMBOL(<lfs_delete>).

        DATA(lv_purchasedoc) = <lfs_delete>-PurchaseDocument.
      ENDLOOP.

      APPEND VALUE #( flag = 'D' po_document = lv_purchasedoc ) TO lcl_trbuffer=>mt_purchasedoc_buffer.
    ENDIF.
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
  DATA: LT_PURCHASE_create TYPE TABLE OF zrishi_podoc,
        lt_purchase_delete TYPE TABLE OF zrishi_podoc.
  IF lcl_trbuffer=>mt_purchasedoc_buffer IS NOT INITIAL.
    "Create
    lt_purchase_create = VALUE #( FOR  ls_podata IN lcl_trbuffer=>mt_purchasedoc_buffer WHERE ( flag = 'C' ) ( ls_podata-data ) ).
    IF lt_purchase_create IS NOT INITIAL.
      DATA(lv_purchase_doc) = lt_purchase_create[ 1 ]-po_document.
      INSERT zrishi_podoc FROM TABLE @lt_purchase_create.
      IF sy-subrc EQ 0.




      ELSE.
*        lref_message = NEW cl_abap_behv( )->new_message(
*                                                        id       =  'ZRISHI_MSG'
*                                                        number   = '002'
*                                                        severity = if_abap_behv_message=>severity-success
*                                                          ).

      ENDIF.

    ENDIF.
    "Delete
    lt_purchase_delete = VALUE #( FOR ls_podata IN lcl_trbuffer=>mt_purchasedoc_buffer WHERE ( flag = 'D' ) ( ls_podata-data ) ).
    IF lt_purchase_delete IS NOT INITIAL.

      DELETE zrishi_podoc FROM TABLE @lt_purchase_delete.
      IF sy-subrc EQ 0.
*        lref_message = NEW cl_abap_behv( )->new_message(
*                                                        id       =  'ZRISHI_MSG'
*                                                        number   = '003'
*                                                        severity = if_abap_behv_message=>severity-success
*                                                          ).
*        APPEND VALUE #(   %msg = lref_message ) TO reported-zi_rishi_purchasedoc_u.


      ENDIF.
    ENDIF.
  ENDIF.
ENDMETHOD.

ENDCLASS.
