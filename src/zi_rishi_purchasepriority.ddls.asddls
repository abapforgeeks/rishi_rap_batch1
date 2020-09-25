@AbapCatalog.sqlViewName: 'ZRISHIPOPRIO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Purchase Priority Basic View'
define view ZI_Rishi_PurchasePriority as select from zrishi_poprio {
    //zrishi_postatus
    key priority
}
