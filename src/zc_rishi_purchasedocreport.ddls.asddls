@AbapCatalog.sqlViewName: 'ZRISHIPOREPO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Purchase Document Report'
@Metadata.allowExtensions: true
define view ZC_Rishi_PurchaseDocReport
  as select from ZI_Rishi_PurchaseDocTotalPrice
{
      //ZI_Rishi_PurchaseDocTotalPrice
      @ObjectModel.text.element: ['PurchaseDesc']
  key PurchaseDocument,
      TotalPrice,
      Currency,
      @Semantics.text: true
      PurchaseDesc,
      @Consumption.valueHelpDefinition: [{ entity:{ name : 'zc_rishi_POStatusVH',element: 'status'} }]

      @ObjectModel.text.element: ['StatusText']
      PurchaseStatus,
      @Semantics.text: true
      _Status.text   as StatusText,
      @ObjectModel.text.element: ['PriorityText']
      PurchasePrio,
      @Semantics.text: true

      _Priority.text as PriorityText,
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
