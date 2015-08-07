public class tablesorting
{
  public list<contact> tablevar{get;set;}
  public contact c{get;set;}
  public String firstname{get;set;}
  public tablesorting(ApexPages.StandardController controller)
  {
    list<contact> tablevar=new list<contact>();
    c=new contact();
   //tablevar=[select firstname,lastname,id from contact];
  }
  
  public pagereference select1()
 {
  system.debug('+++'+c.Select_Sorting_parameter__c);
  if(c.Select_Sorting_parameter__c=='firstname')
  {
   tablevar=[select firstname,lastname,id from contact order by firstname];
  }
  if(c.Select_Sorting_parameter__c=='lastname')
  {
   tablevar=[select firstname,lastname,id from contact order by lastname];
  }
  if(c.Select_Sorting_parameter__c=='id')
  {
   tablevar=[select firstname,lastname,id from contact order by id];
  }
   //pagereference p=new pagereference('https://c.ap1.visual.force.com/apex/admin');
   return Null;
 }
}