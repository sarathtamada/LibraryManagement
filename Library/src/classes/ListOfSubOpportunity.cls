public with sharing class ListOfSubOpportunity {

  
   

    public ListOfSubOpportunity() {

    }

    public ListOfSubOpportunity(ApexPages.StandardController controller) {
   
    }
     
public List<opportunity> oppList = new List<opportunity>();

public List<opportunity> getSubOpportunityList()
{
 oppList = [Select Name,CloseDate,Sub_Type__c,id,StageName from Opportunity where Parent_Oportunity__c =: ApexPages.currentPage().getParameters().get('id')];
 return oppList;
 
}

 public PageReference NewOpp() 
 {
 
        PageReference page = new PageReference('/apex/Opportunity?id='+ApexPages.currentPage().getParameters().get('id') );

        page.setRedirect(true);

        return page; 
       
    }
    public Pagereference pageredir()
    {

        Id id= ApexPages.currentPage().getParameters().get('id'); 
        if(Id!=null)
            {
            Pagereference newpage = new Pagereference ('/apex/ListOfSubOpportunity?'+id+'&action=edit');
           return newpage;
            }
        else
            {
           Pagereference newpage = new PageReference('/apex/Opportunity?id='+ApexPages.currentPage().getParameters().get('myid') );
            return newpage;
           }
        }

}