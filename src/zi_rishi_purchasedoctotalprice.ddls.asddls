@AbapCatalog.sqlViewName: 'ZRISHIPOPRICE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Purchase Document Total Price'
define view ZI_Rishi_PurchaseDocTotalPrice
  as select from ZI_Rishi_PurchaseDoc
  association[0..*] to I_Currency as _Currency on $projection.Currency = _Currency.Currency
{
  key PurchaseDocument,
  @Semantics.amount.currencyCode: 'Currency'
      sum( _PurchaseItems.TotalPrice ) as TotalPrice,
  @Semantics.currencyCode: true
        _PurchaseItems.Currency     as Currency,
      PurchaseDesc,
      PurchaseStatus,
      PurchasePrio,

      CreatedBy,
      CreatedOn,
      ChangedBy,

      _PurchaseItems,
      _Priority,
      _Status,
      _Currency
}
group by
  PurchaseDocument,
  PurchaseDesc,
  _PurchaseItems.Currency,
  PurchaseDesc,
  PurchaseStatus,
  PurchasePrio,

  CreatedBy,
  CreatedOn,
  ChangedBy;
