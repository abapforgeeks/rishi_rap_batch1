@AbapCatalog.sqlViewName: 'ZRISHIPOSTAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interf.View for Purchase Status'
@ObjectModel.resultSet.sizeCategory: #XS
define view ZI_Rishi_PurchaseStatus as select from zrishi_postatus {
    //zrishi_postatus
    @ObjectModel.text.element: ['text']
    key status,
    @Semantics.text: true
    text
}
