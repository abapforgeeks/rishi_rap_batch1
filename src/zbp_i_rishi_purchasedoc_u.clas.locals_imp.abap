CLASS lcl_trbuffer DEFINITION.
  PUBLIC SECTION.

    CLASS-DATA: mt_create_purchasedoc TYPE TABLE OF zrishi_podoc.
    CLASS-DATA: mt_delete_purchasedoc TYPE TABLE OF zrishi_podoc.
    CLASS-DATA: mt_update_purchasedoc TYPE TABLE OF zrishi_podoc.
ENDCLASS.


CLASS lhc_ZI_RISHI_PURCHASEDOC_U DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create_purchaseorder FOR MODIFY
      IMPORTING it_purchase_create FOR CREATE zi_rishi_purchasedoc_u.

    METHODS delete_purchaseorder FOR MODIFY
      IMPORTING it_delete_po FOR DELETE zi_rishi_purchasedoc_u.

    METHODS update_purchaseorder FOR MODIFY
      IMPORTING it_update_po FOR UPDATE zi_rishi_purchasedoc_u.

    METHODS read FOR READ
      IMPORTING keys FOR READ zi_rishi_purchasedoc_u RESULT result.




ENDCLASS.

CLASS lhc_ZI_RISHI_PURCHASEDOC_U IMPLEMENTATION.

  METHOD create_purchaseorder.

    DATA: lt_messages TYPE bapirettab.
    DATA: lt_purchase_buffer TYPE TABLE OF zi_rishi_purchasedoc_u.
    DATA: ls_buffer TYPE zrishi_podoc.

    DATA(lv_cid) = it_purchase_create[ 1 ]-%cid.
    "Step1: Prepare Buffer table for purchase document based on the input data.
    "Prepare Buffer table
    CALL FUNCTION 'ZRISHI_PREPARE_PURCHASEDOC'
      EXPORTING
        it_purchase_docs = it_purchase_create
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
      LOOP AT lt_messages ASSIGNING FIELD-SYMBOL(<lfs_msg>).
        APPEND VALUE #( %cid = lv_cid purchasedocument = lv_purchase_doc ) TO failed-zi_rishi_purchasedoc_u.

        lref_message = NEW cl_abap_behv( )->new_message(
                                                         id       =  <lfs_msg>-id
                                                         number   = <lfs_msg>-number
                                                         severity = CONV #( <lfs_msg>-type )
                                                         v1 = <lfs_msg>-message_v1 ).
        APPEND VALUE #( %cid = lv_cid purchasedocument = lv_purchase_doc ) TO reported-zi_rishi_purchasedoc_u.
      ENDLOOP.
    ENDIF.



  ENDMETHOD.

  METHOD delete_purchaseorder.
    IF it_delete_po IS NOT INITIAL.
*Get purchase doc number to be deleted.(single instance)
      LOOP AT it_delete_po ASSIGNING FIELD-SYMBOL(<lfs_delete>).
        DATA(lv_purchasedoc) = <lfs_delete>-PurchaseDocument.
        DATA(lv_cid) = <lfs_delete>-%cid_ref.
      ENDLOOP.
      APPEND VALUE #(  po_document = lv_purchasedoc ) TO lcl_trbuffer=>mt_delete_purchasedoc.
      APPEND VALUE #( %cid = lv_cid purchasedocument = lv_purchasedoc ) TO mapped-zi_rishi_purchasedoc_u.
      DATA(lref_message) = NEW cl_abap_behv( )->new_message(
                                                       id       =  'ZRISHI_MSG'
                                                       number   = '003'
                                                       severity = if_abap_behv_message=>severity-success
                                                       v1 = lv_purchasedoc ).
      APPEND VALUE #( %cid = lv_cid purchasedocument = lv_purchasedoc  %msg = lref_message ) TO reported-zi_rishi_purchasedoc_u.

    ENDIF.
  ENDMETHOD.

  METHOD update_purchaseorder.

    DATA: lt_update_purchase TYPE zrsh_if_rap_batch1=>tt_db_purchase.
    DATA: lt_purchase_control TYPE  zrsh_if_rap_batch1=>tt_purchase_control.

    DATA: lt_messages TYPE bapirettab.
    DATA: lt_update_purchase_final TYPE TABLE OF zrishi_podoc.
    DATA: ls_purchase_control TYPE zrsh_if_rap_batch1=>ts_purchase_control,
          ls_purchase_update  TYPE zrishi_podoc.


    LOOP AT it_update_po ASSIGNING FIELD-SYMBOL(<lfs_update_po>).

      ls_purchase_control-purchasedocument = <lfs_update_po>-PurchaseDocument.
      ls_purchase_control-purchasedesc = xsdbool( <lfs_update_po>-%control-PurchaseDesc = cl_abap_behv=>flag_changed ).
      ls_purchase_control-currency = xsdbool( <lfs_update_po>-%control-Currency =  cl_abap_behv=>flag_changed ).
      ls_purchase_control-purchaseprio = xsdbool( <lfs_update_po>-%control-PurchasePrio = cl_abap_behv=>flag_changed ).
      ls_purchase_control-purchasestatus = xsdbool( <lfs_update_po>-%control-PurchaseStatus = cl_abap_behv=>flag_changed ).

      ls_purchase_update = CORRESPONDING #( <lfs_update_po> MAPPING FROM ENTITY ).
      APPEND ls_purchase_update TO lt_update_purchase.
      APPEND ls_purchase_control TO lt_purchase_control.

    ENDLOOP.


    CALL FUNCTION 'ZRISHI_PURCHASE_UPDATE'
      EXPORTING
        it_purchase_doc     = lt_update_purchase
        it_purchase_control = lt_purchase_control
      IMPORTING
        et_purchase_update  = lcl_trbuffer=>mt_update_purchasedoc
        et_messages         = lt_messages.


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

    "Purchase Document Create
    CALL FUNCTION 'ZRISHI_PURCHASE_DATA_SAVE'
      EXPORTING
        it_purchase_create = lcl_trbuffer=>mt_create_purchasedoc
        it_purchase_delete = lcl_trbuffer=>mt_delete_purchasedoc
        it_purchase_update = lcl_trbuffer=>mt_update_purchasedoc.


  ENDMETHOD.

ENDCLASS.
