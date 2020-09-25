@AbapCatalog.sqlViewName: 'ZRIHIPOITEMS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Purchase Doc Items Consumption View'
define view ZC_Rishi_PurchaseItems as select from ZI_Rishi_PurchaseItems {
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
