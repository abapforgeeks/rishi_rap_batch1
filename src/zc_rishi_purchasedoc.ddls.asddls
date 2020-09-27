@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Rishi Purchase Doc'
@Metadata.allowExtensions: true
@Search.searchable: true

define root view entity ZC_RISHI_PurchaseDoc as projection on ZI_RISHI_PURCHASEDOC_U {
    //ZI_RISHI_PURCHASEDOC_U
     //ZI_Rishi_PurchaseDocTotalPrice
      @ObjectModel.text.element: ['PurchaseDesc']
  key PurchaseDocument,
      TotalPrice,
      
      @Consumption.valueHelpDefinition: [{ entity:{ name : 'I_Currency',element: 'Currency'} }]
      Currency,
      @Semantics.text: true
      @Search:{  fuzzinessThreshold: 0.7,ranking: #HIGH }
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
      
      PoPriceCriticality,
      IsApprovalReqiored,
      
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
