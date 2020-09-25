@AbapCatalog.sqlViewName: 'ZRISHIPOREPO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Purchase Document Report'
@Metadata.allowExtensions: true
define view ZC_Rishi_PurchaseDocReport as select from ZI_Rishi_PurchaseDocTotalPrice {
    //ZI_Rishi_PurchaseDocTotalPrice
    key PurchaseDocument,
    TotalPrice,
    Currency,
    PurchaseDesc,
    PurchaseStatus,
    PurchasePrio,
    CreatedBy,
    CreatedOn,
    ChangedBy,
    /* Associations */
    //ZI_Rishi_PurchaseDocTotalPrice
    _Currency,
    _Priority,
    _PurchaseItems,
    _Status
}
