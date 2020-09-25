@AbapCatalog.sqlViewName: 'ZRISHIPODOC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic Interf.View for Purchase Document'
//@VDM.viewType: #BASIC
define view ZI_Rishi_PurchaseDoc as select from zrishi_podoc 
association[1..*] to ZI_Rishi_PurchaseItems as _PurchaseItems on $projection.PurchaseDocument = _PurchaseItems.PurchaseDocument 
association[0..1] to ZI_Rishi_PurchaseStatus as _Status on $projection.PurchaseStatus = _Status.status
association[0..1] to ZI_Rishi_PurchasePriority as _Priority on $projection.PurchasePrio = _Priority.priority
{

    //zrishi_podoc
    @ObjectModel.text.element: ['PurchaseDesc']
    key po_document as PurchaseDocument,
    @Semantics.text: true
    po_desc as PurchaseDesc,
    
    po_status as PurchaseStatus,
    po_priority as PurchasePrio,
    ccode as CompanyCode,
    create_by as CreatedBy,
    
    created_date_time as CreatedOn,
    changed_date_time as ChangedBy,
    
    _PurchaseItems,
    _Status,
    _Priority
}
