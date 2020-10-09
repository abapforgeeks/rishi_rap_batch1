@AbapCatalog.sqlViewName: 'ZRISHIPO_M'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Purchase Doc Approval'
@ObjectModel.semanticKey: ['PurchaseDocument']
@ObjectModel.representativeKey: 'PurchaseDocument'
define root view ZI_RISHI_po_valdet_demo_u
  as select from ZI_Rishi_PurchaseDocTotalPrice
{
      //ZI_Rishi_PurchaseDocTotalPrice
  key PurchaseDocument,
      TotalPrice,
      case when TotalPrice >= 0 and  TotalPrice < 250 then 3
      when  TotalPrice >= 250 and  TotalPrice < 500 then 2
      when TotalPrice >=500 then 1
      else 0 end                                       as PoPriceCriticality,

      case when TotalPrice > 500 then 'X' else ' ' end as IsApprovalReqiored,

      Currency,
      PurchaseDesc,
      PurchaseStatus,
      PurchasePrio,
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
      _PurchaseItems,
      _Status
}
