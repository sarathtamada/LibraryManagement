public class opportunityListCon {
  // ApexPages.StandardSetController must be instantiated   
  // for standard list controllers  
       public Boolean Checked{get;set;} 
    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                      [select name,closedate from Opportunity]));
            }
            return setCon;
        }
        set;
    }

    // Initialize setCon and return a list of records
   
    public List<Opportunity> getOpportunities() {
         setCon.setpagesize(5);
         return (List<Opportunity>) setCon.getRecords();
    }
   
}