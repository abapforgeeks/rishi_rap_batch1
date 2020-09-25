@AbapCatalog.sqlViewName: 'ZRISHIVENDOR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Vendor Basic View'
define view ZI_Rishi_Vendor as select from zrishi_vendor {
    //zrishi_vendor
    key vendor_id as VendorId,
    city as City,
    comp_name as CompanyName,
    email as EmailId,
    phone as PhoneNumber
}
