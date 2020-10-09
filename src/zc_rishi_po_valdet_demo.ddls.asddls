@EndUserText.label: 'Demo on Validations and Determination'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_RISHI_PO_VALDET_DEMO
  as projection on ZI_RISHI_po_valdet_demo_u
{
      //ZI_RISHI_PURCHASEDOC_U
      @ObjectModel.text.element: ['PurchaseDesc']
  key PurchaseDocument,
      TotalPrice,
      Currency,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Search.ranking: #HIGH
      PurchaseDesc,
      @Consumption.valueHelpDefinition: [{ entity:{ name : 'zc_rishi_POStatusVH',element: 'status'} }]

      @ObjectModel.text.element: ['StatusText']
      PurchaseStatus,
      PoPriceCriticality,
      IsApprovalReqiored,
      @Semantics.text: true
      _Status.text   as StatusText,
      @ObjectModel.text.element: ['PriorityText']
      PurchasePrio,
      @Semantics.text: true

      _Priority.text as PriorityText,
      @Semantics.user.createdBy: true
      CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      CreatedOn,
      @Semantics.systemDateTime.lastChangedAt: true
      ChangedBy,
      /* Associations */
      //ZI_Rishi_PurchaseDocTotalPrice
      _Currency,
      _Priority,
      _Status
}
