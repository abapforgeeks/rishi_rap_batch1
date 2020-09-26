@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Rishi Purchase Doc'
define root view entity ZC_RISHI_PurchaseDoc as projection on ZI_RISHI_PURCHASEDOC_U {
    //ZI_RISHI_PURCHASEDOC_U
    key PurchaseDocument,
    TotalPrice,
    PoPriceCriticality,
    IsApprovalReqiored,
    Currency,
    PurchaseDesc,
    PurchaseStatus,
    PurchasePrio,
    CreatedBy,
    CreatedOn,
//    ChangedBy,
    /* Associations */
    //ZI_RISHI_PURCHASEDOC_U
    _Currency,
    _Priority,
    _PurchaseItems,
    _Status
}
