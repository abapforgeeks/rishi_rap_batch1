CLASS lcl_trbuffer DEFINITION.
  PUBLIC SECTION.

    CLASS-DATA: mt_create_purchasedoc TYPE TABLE OF zrishi_podoc.
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
    DATA: lt_messages TYPE bapirettab.
    DATA: lt_purchase_buffer TYPE TABLE OF zi_rishi_purchasedoc_u.
    DATA: ls_buffer TYPE zrishi_podoc.

    DATA(lv_cid) = it_purchase_docs[ 1 ]-%cid.
    "Step1: Prepare Buffer table for purchase document based on the input data.
    "Prepare Buffer table
    CALL FUNCTION 'ZRISHI_PREPARE_PURCHASEDOC'
      EXPORTING
        it_purchase_docs = it_purchase_docs
      IMPORTING
        et_purchase_docs = lt_purchase_buffer
        et_messages      = lt_messages.
    "Step 2: Message Handling.
    IF NOT line_exists( lt_messages[ type = 'E' ] ).
      DATA(lv_purchase_doc) = lt_purchase_buffer[ 1 ]-PurchaseDocument.
      "Step 3: Buffer Insert
      "mapping CDS View data to DB table.
      lcl_trbuffer=>mt_create_purchasedoc = CORRESPONDING #( lt_purchase_buffer MAPPING FROM ENTITY ).
      APPEND VALUE #( %cid = lv_cid purchasedocument = lv_purchase_doc ) TO mapped-zi_rishi_purchasedoc_u.
      DATA(lref_message) = NEW cl_abap_behv( )->new_message(
                                                       id       =  'ZRISHI_MSG'
                                                       number   = '001'
                                                       severity = if_abap_behv_message=>severity-success ).
      APPEND VALUE #( %cid = lv_cid purchasedocument = lv_purchase_doc  %msg = lref_message ) TO reported-zi_rishi_purchasedoc_u.

    ELSE.
      APPEND VALUE #( %cid = lv_cid purchasedocument = lv_purchase_doc ) TO failed-zi_rishi_purchasedoc_u.

      lref_message = NEW cl_abap_behv( )->new_message(
                                                       id       =  'ZRISHI_MSG'
                                                       number   = '004'
                                                       severity = if_abap_behv_message=>severity-error ).
      APPEND VALUE #( %cid = lv_cid purchasedocument = lv_purchase_doc ) TO reported-zi_rishi_purchasedoc_u.

    ENDIF.



  ENDMETHOD.

  METHOD delete.
*    IF it_delete_po IS NOT INITIAL.
*
*      LOOP AT it_delete_po ASSIGNING FIELD-SYMBOL(<lfs_delete>).
*
*        DATA(lv_purchasedoc) = <lfs_delete>-PurchaseDocument.
*      ENDLOOP.
*
*      APPEND VALUE #( flag = 'D' po_document = lv_purchasedoc ) TO lcl_trbuffer=>mt_purchasedoc_buffer.
*    ENDIF.
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
    IF lcl_trbuffer=>mt_create_purchasedoc IS NOT INITIAL.
      CALL FUNCTION 'ZRISHI_PURCHASE_DATA_SAVE'
        EXPORTING
          it_purchase_doc = lcl_trbuffer=>mt_create_purchasedoc.
    ENDIF.

    "Delete
*      lt_purchase_delete = VALUE #( FOR ls_podata IN lcl_trbuffer=>mt_purchasedoc_buffer WHERE ( flag = 'D' ) ( ls_podata-data ) ).
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

  ENDMETHOD.

ENDCLASS.
