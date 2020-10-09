@AbapCatalog.sqlViewName: 'ZRISHI_OVPFILTER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'OVP Filter'
define view ZC_RISHI_POFilter_OVP
  as select from ZI_Rishi_PurchaseDoc
{
  key PurchaseDocument,
      //    @Consumption.valueHelpDefinition: [{ entity:{ name:'zc_rishi_POStatusVH',element:'Status' } }]
      @UI.selectionField: [{ position: 10, exclude: true }]
      '' as Priority,
      @UI.selectionField: [{ position: 20,exclude: true }]
      @Consumption.valueHelpDefinition: [{ entity:{ name:'zc_rishi_POStatusVH',element:'Status' } }]
      '' as Status
}
