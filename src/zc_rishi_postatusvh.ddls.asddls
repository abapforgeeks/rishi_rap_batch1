@AbapCatalog.sqlViewName: 'ZRISHIPOSTVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Purchase Status Value Help'
//@ObjectModel.dataCategory: #VALUE_HELP
@Search.searchable: true
define view zc_rishi_POStatusVH as select from ZI_Rishi_PurchaseStatus {
    //ZI_Rishi_PurchaseStatus
    @ObjectModel.text.element: ['text']
    key status,
    @Search:{defaultSearchElement: true,fuzzinessThreshold: 0.70,ranking: #MEDIUM }
    text
}
