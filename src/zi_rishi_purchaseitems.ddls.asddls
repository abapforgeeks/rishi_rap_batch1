@AbapCatalog.sqlViewName: 'ZRISHIPOITEMS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic Interf.View on Purchase Items'
//@VDM.viewType: #BASIC
define view ZI_Rishi_PurchaseItems as select from zrishi_poitem 
association[1..1] to ZI_Rishi_PurchaseDoc as _PurchaseHeader on $projection.PurchaseDocument = _PurchaseHeader.PurchaseDocument
association[1..1] to ZI_Rishi_Vendor as _Vendor on $projection.Vendor = _Vendor.VendorId
association[1..1] to I_Currency as _Currency on $projection.Currency = _Currency.Currency
association[1..1] to I_UnitOfMeasure as _QuantityMeasure on $projection.Unit = _QuantityMeasure.UnitOfMeasure
{
    //zrishi_poitem
    key po_document as PurchaseDocument,
    @ObjectModel.text.element: ['ItemDesc']
    key po_item as PurchaseItem,
    @Semantics.text: true
    item_desc as ItemDesc,
    vendor as Vendor,
    @Semantics.amount.currencyCode: 'currency'
    price as Price,
    @Semantics.currencyCode: true
    currency as Currency,
    
    @Semantics.quantity.unitOfMeasure: 'unit'
    quantity as Quantity,
    @Semantics.unitOfMeasure: true
    unit as Unit,
    change_date_time as ChangeDateTime,
    
    _PurchaseHeader,
    _Vendor,
    _Currency,
    _QuantityMeasure
    
}
