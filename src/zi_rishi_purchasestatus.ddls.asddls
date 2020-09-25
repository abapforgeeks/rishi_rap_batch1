@AbapCatalog.sqlViewName: 'ZRISHIPOSTAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interf.View for Purchase Status'
define view ZI_Rishi_PurchaseStatus as select from zrishi_postatus {
    //zrishi_postatus
    key status
}
