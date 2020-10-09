*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lhc_purchase_handler DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS: validate_status FOR VALIDATE ON SAVE IMPORTING keys FOR PurchaseDoc~validateStatus.
ENDCLASS.
CLASS lhc_purchase_handler IMPLEMENTATION.

  METHOD validate_status.
    DATA(lv_test) = abap_true.
    DATA: lt_statuses TYPE TABLE OF zrishi_postatus.
    "Step1: Read the current instance data.;'ZI_RISHI_po_valdet_demo_u' is the root entity of our business object.
    READ ENTITIES OF ZI_RISHI_po_valdet_demo_u
    ENTITY PurchaseDoc
     FIELDS ( PurchaseStatus )
     WITH CORRESPONDING #(  keys )
    RESULT DATA(lt_purchasedoc).
    "Step2: Keep Status in separate table, to fetch the relevant statuses
    lt_statuses = CORRESPONDING #( lt_purchasedoc MAPPING status = PurchaseStatus EXCEPT * ).

    "Step3: Check if the status exist in the DB
    SELECT  FROM zrishi_postatus FIELDS status
    FOR ALL ENTRIES IN @lt_statuses
    WHERE status = @lt_statuses-status
    INTO TABLE @DATA(lt_statuses_db).

    "Step4: Validate the status
    LOOP AT lt_purchasedoc ASSIGNING FIELD-SYMBOL(<lfs_podoc>).

      IF NOT line_exists( lt_statuses_db[ status = <lfs_podoc>-PurchaseStatus ] ).
        APPEND VALUE #( purchasedocument = <lfs_podoc>-PurchaseDocument ) to failed-purchasedoc.

        DATA(lref_message) = NEW cl_abap_behv( )->new_message(
                                                         id       =  'ZRISHI_MSG'
                                                         number   = 008
                                                         severity = if_abap_behv_message=>severity-error
                                                        ).
        APPEND VALUE #( purchasedocument = <lfs_podoc>-purchasedocument
                        %msg = lref_message
                        %element-purchasestatus = if_abap_behv=>mk-on ) to reported-purchasedoc.

      ENDIF.
    ENDLOOP.



  ENDMETHOD.

ENDCLASS.
