@AbapCatalog.sqlViewName: 'ZRISHI_POITEM_U'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Unmanaged Purchase Items'
define view ZI_RISHI_PurchaseItems_U as select from ZI_Rishi_PurchaseItems
association to parent ZI_RISHI_PURCHASEDOC_U as _PurchaseHeader on $projection.PurchaseDocument = _PurchaseHeader.PurchaseDocument
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
    _PurchaseHeader,
    _QuantityMeasure,
    _Vendor
}
