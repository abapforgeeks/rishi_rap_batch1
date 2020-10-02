@EndUserText.label: 'Purchase Items Projection'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity Zc_RISHI_PURCHASEITEMS_U_V1 as projection on ZI_RISHI_PurchaseItems_U {
    //ZI_RISHI_PURCHASEITEMS_U
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
    //ZI_RISHI_PURCHASEITEMS_U
    _Currency,
    _PurchaseHeader:redirected to parent ZC_RISHI_PurchaseDoc,
    _QuantityMeasure,
    _Vendor
}
