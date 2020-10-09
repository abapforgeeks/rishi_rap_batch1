@AbapCatalog.sqlViewName: 'ZRISHI_POITEM_M'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Unmanaged Purchase Items'
define view ZI_RISHI_POITEM_VALDET_M as select from ZI_Rishi_PurchaseItems
association to parent ZI_RISHI_po_valdet_demo_u as _POHeader on $projection.PurchaseDocument = _POHeader.PurchaseDocument
 {
    //ZI_Rishi_PurchaseItems
    key PurchaseDocument,
    key PurchaseItem,
    ItemDesc,
    Vendor,
    Price,
    TotalPrice,
    Currency,
    Quantity,
    
    Unit,
    ChangeDateTime,
    /* Associations */
    //ZI_Rishi_PurchaseItems
    _Currency,
    _POHeader,
    _QuantityMeasure,
    _Vendor
}
