public with sharing class extActivitiesExport  {

    ApexPages.StandardSetController con;
    public extActivitiesExport (ApexPages.StandardSetController controller) {
        con = controller;
    }
    public Boolean generateTestException { get;set; }
    public PageReference export() {
        List<Opportunity> seletedOpp = (List<Opportunity>) con.getSelected();
        return null;
    }
}