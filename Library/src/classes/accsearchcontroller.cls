public with sharing class accsearchcontroller {  
   public list <account> acc {get;set;}  
   public string searchstring {get;set;}  
   public accsearchcontroller(ApexPages.StandardController controller) {  
   }  
   public void search(){  
     string searchquery='select name,id from account where name like \'%'+searchstring+'%\' Limit 20';  
     acc= Database.query(searchquery);  
   }  
   public void Active(){
   }
    
 }